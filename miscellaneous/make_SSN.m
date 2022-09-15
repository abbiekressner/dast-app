function [speech_shaped_noise,speech] = make_SSN(target_folder,len_sec,dBFS)

% Filter white noise using the coefficients of the LTASS

%% Set defaults
if nargin < 3
    dBFS = -26;
end
if nargin < 2
    len_sec = 20*60; % 20 min
end


%% Read in speech
% Get list of wav files
list = dir( fullfile(target_folder,'*.wav') );

% Loop through list
speech = cell(size(list));
for ll = 1:numel(list)
    % Load in the wav file
    [speech_tmp,fs] = audioread(fullfile(target_folder,list(ll).name));

    % Store the sentence
    speech{ll} = speech_tmp(500e-3*fs+1:end-500e-3*fs); % TODO Change to VAD?
end
speech = cell2mat(speech);
       

%% LPC method
% % Set parameters
% p_lpc = 10; % pth-order linear predictor
% 
% % Find the coefficients of a pth-order linear predictor
% lpc_coeffs = lpc(speech,p_lpc); 
% 
% Create the speech-shaped noise
% % Initialize white noise
% noise = rand(len_sec*fs,1);
% 
% % Shape the white noise
% speech_shaped_noise = filter(1,lpc_coeffs,noise); 


%% Random-phase method
spectrum = abs(fft(speech)).*exp(1i*2*pi*rand(size(speech))); % Apply the fourier transform and randomizing the phases of all the spectral components
speech_shaped_noise = real(ifft(spectrum)); % Obtain the real parts of the IFFT
speech_shaped_noise = speech_shaped_noise(1:round(len_sec*fs));


%% Adjust the level
% Normalize the rms to one
speech_shaped_noise = speech_shaped_noise/rms(speech_shaped_noise);

% Adjust to the desired level
speech_shaped_noise = 10^(dBFS/20)*speech_shaped_noise;


%% Plot long-term average spectrums
if nargout == 0
    n_filter = 256;
    [H1,F1] = freqz(speech,1,n_filter,fs); 
    H2 = freqz(speech_shaped_noise,1,n_filter,fs); 
    
    semilogx(F1/1000,20*log10(abs([H1,H2])),'linewidth',2);
    ax = gca; 
    xlim([0 20]); % define x-axis limits from 20 Hz to 20 kHz
    grid on; 
    grid minor;
    xlabel('Frequency (kHz)');
    ylabel('dB');
    title('LTASS');
    ax.FontSize = 8;
    ax.FontWeight = 'bold';
    legend({'Speech','SSN'});
end

end