# Danish Sentence Test (DAST) #

![Screenshot](files/DAST-screenshot.png)

The Danish Sentence Test (DAST) app is an application for facilitating
speech-in-noise testing with material from the DAST and ECO-DAST corpora of audio 
and audio-visual recordings.


## Installation ##

1. Download this repository using one of the following methods:  
  * Clone or fork this repository  
  * Download the contents as a zip file  

2. Download the desired corpus or corpora:
  * Danish Sentence Test (DAST) Sentences corpus (https://doi.org/10.11583/DTU.24058110)
  * Everyday Conversational Danish Sentence Test (ECO-DAST) corpus (link coming soon)

3. Move the speech material into your `dast-app` folder as follows:  
  `../dast-app/DAST.mlapp`
  `../dast-app/DASTchannels.mlapp`  
  `../dast-app/DASTsettings.mlapp`
  `../dast-app/files/`
  `../dast-app/presets/`
  `../dast-app/Corpus_DAST/`
  `../dast-app/Corpus_ECODAST/`

Note that you should maintain the file structure within each corpus folder(s). Specifically, there should be three subfolders (i.e., 'metadata','speech','noise'). For example:
  `../dast-app/Corpus_DAST/metadata/`
  `../dast-app/Corpus_DAST/speech/`
  `../dast-app/Corpus_DAST/noise/`


## Usage ##

### With a Matlab license ###
* Open Matlab (NOTE requires 2022a or later)
* Change your current directory to the DAST-app repository
* Start the application by running DAST.mlapp

### Without a Matlab license ###
* Compiled, standalone versions are in development. Stay tuned...


## Publications ##

* Kressner, A. A., Rico, K. M. J., Kizach, J., Man, B. K. L., Pedersen, A. K., Bramsløw, L., Hansen, L. B., Balling, L. W., Kirkwood, B., May, T., “A corpus of audio-visual recordings of linguistically balanced, Danish sentences for speech-in-noise experiments”. In: Speech Communication (2024). doi: https://doi.org/10.1016/j.specom.2024.103141.

* Kressner, A. A., Jensen-Rico, K. M., Pedersen, A. K., Bramsløw, L., Kirkwood, B., “Psychoacoustic characterization of linguistically balanced, Danish sentences for speech-in-noise experiments”. In: International Journal of Audiology (2025). doi: http://doi.org/10.1080/14992027.2025.2470378

* Man, B. K. L., Andersen, T. S., Kressner, A. A., “Measuring the audiovisual benefit in linguistically and psychoacoustically balanced sentences using the Audiovisual Danish Sentence Test”. In: International Journal of Audiology (in review).

* Andersen, P. K., Bramsløw, L., Pedersen, A. K., Dau, T., Kressner, A. A., “Investigating naturalness with a more ecologically valid speech material in the Everyday Conversational Danish Sentence Test (ECO-DAST)”. In: Ear & Hearing (in review).

* Kressner, A. A., Jensen-Rico, K. M., Pedersen, A. K., Bramsløw, L., Kirkwood, B., “An adaptive Danish Sentence Test (DAST) for measuring speech reception thresholds”. In: International Journal of Audiology (in preparation).

* Kressner, A. A., Jensen-Rico, K. M., Jordell, D. H., Kjærbøl, E., “The Quick Danish Sentence Test (Quick-DAST) for measuring speech reception thresholds clinically”. In: International Journal of Audiology (in preparation).


## Contact ##
* Abigail Anne Kressner (aakress@dtu.dk)
