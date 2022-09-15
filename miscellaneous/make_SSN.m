function SSN = make_SSN(target_folder,dBFS)

% Filter white noise using the coefficients of the LTASS


%% Read in speech
% Get list of wav files in base folder
list = dir( target_folder );
wavs = list( ~[list.isdir] );








[sig_speech, fss] = audioread(fullfile(dir_speech, wavs.name)); 
[sig_noise, ~] = audioread(fullfile(dir_masker, masker.name)); 
%resample to 48kHz to match speech
audiowrite(fullfile(pwd,'audio','Noise','resampled.wav'),sig_noise,fss);
[sig_noise, fsm] = audioread(fullfile(pwd,'audio','Noise','resampled.wav'));
sig_noise = sig_noise(1:length(sig_speech));
       

%% Create filter coefficients
rms_speech = rms(sig_speech);
sig_speech = sig_speech/rms_speech;
nlpc = 1024; %bin
n = 52; %order of filter

% Lpc coefficients and create filter from it. Then filter white noise with
% it
[a1,g1] = lpc(sig_speech,n); % get estimated LPC coefficients of long term average speech spectrum
[H1,F1] = freqz(g1,a1,nlpc,fss); % frequency response of lpc filter
SSN = filter(g1,a1,sig_noise); % filter white noise with LPC coefficients to create SSN

rms_Noise = rms(sig_noise);
rms_SSN = rms(SSN);
SSN = SSN*rms_Noise/rms_SSN; %rms normalisation

% LPC Coefficients for LTASS
[a2,g2] = lpc(SSN,n);
[H2,F2] = freqz(g2,a2,nlpc,fss); % frequency response of digital filter


%% Create SSN
% SAVE SSN .WAV FILE
wav_name = strsplit(wavs.name,'.');
SSN_name = [wav_name{1},'_SSN.wav'];
audiowrite(fullfile(dir_masker_destination,SSN_name),SSN,fss);


%%
% PLOT LTASS VERSUS LTAS OF SSN
p1 = plot(F1/1000,mag2db(abs([H1,H2])),'linewidth',3);

p1(1).Color = 'r';
p1(2).Color = 'b';
ax = gca; 
ax.XLim = ([0.02 20]); % define x-axis limits from 20 Hz to 20 kHz
grid on; 
grid minor;
xlabel('Frequency (kHz)');
ylabel('dB');
title('LTASS');
ax.FontSize = 8;
ax.FontWeight = 'bold';
legend({'LTASS old','LTAS SSN'});

end



%% LISTFILES

%LISTFILES  List all files of directory and its sub-directories.
%   LISTFILES('a_directory') lists the files in a directory and its
%   sub-directories up to a depth of four sub-directories. Pathnames
%   and wildcards may be used.
%   For example, LISTFILES('a_directory', '*.m') lists all the M-files
%   in a directory and its sub-directories up to a depth of four
%   sub-directories.
%   LISTFILES('a_directory', '*.m', 6) lists the files of a directory
%   and its sub-directories up to a depth of six sub-directories. Whereas
%   LISTFILES('a_directory', '*.m',-1) lists the files of all existing
%   sub-directories with infinite recursion. The default recursion depth
%   is to list files of up to four sub-directories.
%
%   D = LISTFILES('a_directory') returns the results in an M-by-1
%   structure with the fields: 
%       name  -- filename (incl. the 'a_directory' path)
%       date  -- modification date
%       bytes -- number of bytes allocated to the file
%       isdir -- 1 if name is a directory and 0 if not
%
%   Hint:
%   To convert the struct array D into a cell-array C, which contains only
%   filenames (one per row), you may do so by typing: C = {D.name}'
%
%   See also DIR, LISTDIRS.

% Auth: Sven Fischer
% Vers: v0.821
function [ stFileList ] = listFiles(szCurDir, szFileMask, iRecursionDepth)

%-------------------------------------------------------------------------%
% Check input arguments.
error(nargchk(0,3,nargin));
% Check output arguments.
error(nargoutchk(0,1,nargout));
%-------------------------------------------------------------------------%

%-------------------------------------------------------------------------%
% Check function arguments and set default values, if necessary.
%-------------------------------------------------------------------------%
if( (nargin<1) || (isempty(szCurDir       )) ), szCurDir        =  ''; end
if( (nargin<2) || (isempty(szFileMask     )) ), szFileMask      = '*'; end
if( (nargin<3) || (isempty(iRecursionDepth)) ), iRecursionDepth =   4; end
%-------------------------------------------------------------------------%

stFileList = dir( fullfile( szCurDir, szFileMask ) );
stFileList = stFileList( find( ~[stFileList.isdir] ) );
for( k = [ 1 : length(stFileList) ] )
  stFileList(k).name = fullfile( szCurDir, stFileList(k).name );
end

% If we have to process sub-directories recursively...
if( (iRecursionDepth > 0) || (iRecursionDepth == -1) )
    % Decrease recursion counter by one, if not set to infinite...
    if( iRecursionDepth > 0 ), iRecursionDepth = iRecursionDepth - 1; end

    % Get a list of all existing sub-directories (exclusive '.' and '..').
    stSubDirs = dir( szCurDir );
    stSubDirs = stSubDirs( find( [stSubDirs.isdir] ) );
    if( ~isempty(stSubDirs) )
        if( strcmp(stSubDirs(1).name,  '.') ), stSubDirs(1) = []; end
        if( strcmp(stSubDirs(1).name, '..') ), stSubDirs(1) = []; end

        % Process all subdirectories and append all each file list to the
        % list created above.
        for( k = [ 1 : length(stSubDirs) ] )
            szSubDir = fullfile( szCurDir, stSubDirs(k).name);
            stFileList = [ stFileList; ...
                listFiles( szSubDir, szFileMask, iRecursionDepth) ];
        end
    end
end

%   ***********************************************************************
%   This program is free software: you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or
%   (at your option) any later version.
% 
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
% 
%   You should have received a copy of the GNU General Public License
%   along with this program.  If not, see <http://www.gnu.org/licenses/>.
%   ***********************************************************************