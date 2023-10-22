=======================================================================
Text Proccessing with SED and AWK tools
=======================================================================

Description
============

This repository contains a BASH shell script that I implemented to manage a user log file
events (log files) for navigating social networks on the Internet. The file event.dat contains elements according to
the following wording and formatting:

id|lastName|firstName|gender|birthday|joinDate|IP|browserUsed|socialmedia



The script tools.sh support the following functionallities:
                    
              #. Execution of the command: ::

                     ./tool.sh -f <file>

                 Displays the entire contents of the file, without the comment lines that should
                 have been ignored.
              
              #. Execution of the command: ::

                     ./tool.sh -f <file> -id <id>

                 Displays the first name, last name, and date of birth of the user with the given one
                 id, separated by a single space.


              #. Execution of the command: ::

                     ./tool.sh --firstnames -f <file>

                 Displays all distinct first names (firstname field) contained in the file,
                 in alphabetical order.


              #. Execution of the command: ::

                     ./tool.sh --lastnames -f <file>
                    
                 Displays all distinct first names (lasttname field) contained in the file,
                 in alphabetical order.


              #. Execution of the command: ::

                     ./tool.sh --born-since <dateA> --born-until <dateB> -f <file>
                     
                 Displays only the rows that correspond to users born from
                 date dateA to date dateB. Either can be given, eg, to display all users born on a day or                         later, or born until some day. For each user that meets the criteria, be displayed
                 the line exactly as it was in the file. Obviously they won't be included
                 comments.




              #. Execution of the command: ::

                     ./tool.sh --socialmedia -f <file>
                     
                 Displays all social media (social media) used by
                 users, in alphabetical order, and next to the mention of his name
                 social network will show the number of users who used it (with
                 exactly one space to separate).




              #. Execution of the command: ::

                     ./tool.sh -f <file> --edit <id> <column> <value>
                     
                 Modifys the file. Specifically, for the user with code <id>, it will replace the
                 column <column> with value <value>. If there is no user with this id, or
                 column is not among the accepted columns 2 through 8 (column 1 corresponding to the same
                 id is not allowed to change), this command will not change anything. Beyond the
                 requested change, nothing else should be changed, i.e. it should
                 the original sorting of records including comments is preserved.





============

Testing the Tool
=============

I now present some examples of execution.


              #. Execution of the command: ::

                    ./tool.sh -f event.dat

                .. image:: Folder_structure.png
              
              #. Execution of the command: ::

                     ./tool.sh -f event.dat -id 1099511629352



              #. Execution of the command: ::

                     ./tool.sh --firstnames -f event.dat | head



              #. Execution of the command: ::

                     ./tool.sh --lastnames -f event.dat | head
                    


              #. Execution of the command: ::

                     ./tool.sh --born-since 1989-12-03 --born-until 1990-01-09 -f event.dat | head



              #. Execution of the command: ::

                     ./tool_386361_.sh --socialmedia -f event.dat
                     

              #. Execution of the command: ::

                     ./tool_386361_.sh -f event.dat --edit 1099511629352 firstName NUNEZ
                     

#. PREPARE THE DATA-----------------------------------------------------------------------------------------

              With this script you can create the samples that will be fed in to the Neural Network. You just have to create the musdb wav folder. With this script you can control the sampling rate of the songs to be processed and the desired Front-End that they will be transformed to.  

                 COMMAND EXAMPLE: ::

                     python Data.py -dataset-params "{ Wav_folder : /home/nnanos/musdb18_wav , Target_folder : /home/nnanos/OPEN_UMX_LIKE_scripts/Spectrograms_NSGT_CQT_mine_24_bass , target_source : bass , Fs : 14700 , seq_dur : 5 , FE_params : { front_end_name : NSGT_CQT , ksi_min : 32.07 , ksi_max : 7000 , B : 24 , matrix_form : 1 } , preproc : None }" 

                ARGUMENTS EXPLANATION:  
                
                     * Wav_folder:
                            It is the PATH of the musdb18_wav dir which have to be in the following structure:
                     
                     .. image:: Folder_structure.png
                     


                     * Target_folder: 
                            It is the PATH of the dir (which is created if not exists) in which the following files will get saved: 
                                        
                                        * Spec_seg_pair_list_train.pt: a python variable (iterable) which contains the spectrogram training input-output pairs (samples).
                                        * Spec_seg_pair_list_valid.pt: The same as before but for the validation.
                     
                                        * Dataset_Params_log.json: Log which contains the parameters of the Dataset that has been created
                                        

                     * Fs: 
                            Sampling rate in which the songs to be processed are resampled  
                     
                     * seq_dur:
                            The duration of the sequence (in sec) that the samples that we feed the network will be. 
                     
                     * FE_params:
                            Is the parameters of the FE (front end ή input represenation) with which we feed the Neural Net.
                            The available FEs and the corresponding arguments are:
                                   
                                          * "nsgt_grr" ::
                                          
                                                 FE_params : { front_end_name : nsgt_grr , ksi_min : 32.07 , ksi_max : 7000 , B : 187 , matrix_form : 1 }
                                          
                                          
                                          * "librosa" ::
                                                 
                                                 FE_params : { front_end_name : librosa , a : 768 , M : 1024 , support : 1024 }
                                                 
                                          * "scipy" ::
                                          
                                                 FE_params : { front_end_name : scipy , a : 768 , M : 1024 , support : 1024 }
                                                 
                                          * "STFT_custom" ::
                                          
                                                 FE_params : { front_end_name : STFT_custom , a : 768 , M : 1024 , support : 1024 }
                                                 
                                          * "NSGT_CQT" :: 
                                                 
                                                 FE_params : { front_end_name : NSGT_CQT , ksi_min : 32.07 , ksi_max : 7000 , B : 24 , matrix_form : 1 }
                                  

       
       |
       |


#. TRAIN-----------------------------------------------------------------------------------------------

       After you have created the dataset you are now ready to begin an experiment with the U-Net model and with the Front-End that you have chosen. 

          COMMAND EXAMPLE: 

              * BEGIN TRAINING ::
              
                     python train.py --root /home/nnanos/OPEN_UMX_LIKE_scripts/Spectrograms_NSGT_CQT_mine_24_bass --target bass --output /home/nnanos/OPEN_UMX_LIKE_scripts/Spectrograms_NSGT_CQT_mine_24_bass/pretr_model --epochs 1000 --batch-size 32 


              * CONTINUE TRAINING ::
              
                     python train.py --model /home/nnanos/OPEN_UMX_LIKE_scripts/Spectrograms_NSGT_CQT_mine_24/pretr_model --checkpoint /home/nnanos/OPEN_UMX_LIKE_scripts/Spectrograms_NSGT_CQT_mine_24/pretr_model --root /home/nnanos/OPEN_UMX_LIKE_scripts/Spectrograms_NSGT_CQT_mine_24 --target vocals --output /home/nnanos/OPEN_UMX_LIKE_scripts/Spectrograms_NSGT_CQT_mine_24/pretr_model --epochs 300 --batch-size 32 --nb-workers 6 
         


          ARGUMENTS EXPLANATION:
          
              * root:
                     It is the PATH of the dir which contains the ,necessary for the training, files created from the Data.py script and as a result the path has to be the same as the one in the Target_folder argument of the Data.py script. Just to remind you the files contained in the dir are the following:
                     * spec_seg_pair_list_train.pt
                     
                     * Spec_seg_pair_list_valid.pt
                     
                     * Dataset_Params_log.json

                     
                     
              * output: 
                     It is the PATH of the dir (which is created if not exists) in which the following files will get saved:
             
                           * model.pth: Necessary file if you want to use the model for inference or evalution

                           * model.json: Log file that contains info about the training of the model (π.χ. trainig-validation losses, execution time, Dataset parameters, arguments του train.py script )

                           * model.chkpnt: Necessary file if you want to continue the training of a model or Fine-Tune it.

              * target:
                     It is the target source that our Neural Net will be trained to separate. 
                     It can be one of the following strings:
                            * "vocals"
                            * "drums"
                            * "bass"
                            * "other"
                     


              __Basic training hyperparameters__

              * epochs:
                     Number of epochs that the model will be trained.


              * batch-size:
                     The batch size that feed the network 
                       (the number of samples that we simultaneously feed the network before it performs a backprop step).
                       The bigger it is     +It is more propable that the optimization algorithm will converge to a local minima.
                                            +Faster processing because we utillize more of the GPU.
                                            -It requires more memory.
                     
                     
               * There are more hyperparameters which can be found `here <https://github.com/sigsep/open-unmix-pytorch/blob/master/docs/training.md>`_  and for the shake of simplicity I do not present them here :).                    


       |
       |


#. EVALUATION-------------------------------------------------------------------------------------------------------------------------

       After you have created the dataset and trained the model (with the above scripts) you are now ready to evaluate the model (compute the BSS performance metrics) with one of the available evaluation methods. In the evaluation phase the songs will be resampled and processed in a block-wise manner exactly as in the training phase.

          COMMAND EXAMPLE: ::

              python evaluate.py --method-name  CQT_mine_24_bass  --Model_dir /home/nnanos/OPEN_UMX_LIKE_scripts/Spectrograms_NSGT_CQT_mine_24_bass/pretr_model  --root_TEST_dir /home/nnanos/musdb18_wav/test  --target bass  --evaldir  /home/nnanos/OPEN_UMX_LIKE_scripts/Spectrograms_NSGT_CQT_mine_24_bass/evaldir_orig_BSS_eval  --cores 1       -eval-params  "{  aggregation_method : median , eval_mthd : BSS_evaluation , nb_chan : 1 , hop : 14700 , win : 14700 }"  



          ARGUMENTS EXPLANATION:   
          

               * method-name: 
                     It is the name of the model that we want to evaluate (i.e. LSTM_CQT_vocals). This parameter exists in order to identify and to compare the model with other models.

               * Model_dir: 
                     It is the PATH for the dir that contains all the necessary files for the pretrained model.
                (it have to be the same as the output argument of the train.py script)

               * root_TEST_dir: 
                      It is the PATH of the dir containing the testing wavs and it has to have the structure mentioned above.

               * evaldir: 
                     It is the PATH of the dir (which is created if not exists) in which the following files will get saved:
              
                            * Eval_Log.json: Contains the arguments of this script 
                            * scores.pickle: Contains the performance metrics in a python pickle variable (this will be used by the script below for visualizing these metrics)


              * eval-params:
                     Is the parameters regarding the evaluation method that will be used.
                     The available evaluation methods and the corresponding arguments are:

                                   * "BSS_evaluation" ::

                                          -eval-params  "{  aggregation_method : median , eval_mthd : BSS_evaluation , nb_chan : 1 , hop : 14700 , win : 14700 }"


                                   * "mir_eval" ::

                                          -eval-params  "{  aggregation_method : median , eval_mthd : mir_eval , nb_chan : 1 , hop : 14700 , win : 14700 }"

                                   * "BSSeval_custom" ::

                                          -eval-params  "{  aggregation_method : median , eval_mthd : BSSeval_custom , nb_chan : 1 , hop : 14700 , win : 14700 }"


         

       |
       |
   
#. PLOTTING EVALUATION-----------------------------------------------------------------------------------------  

       After you have finished with the above phases now you can visualize the results (performance metrics) obtained in the evaluation phase as in the photo below.
       
       * Boxplots:
              .. image:: Boxplots.png
       
       
       * Metrics Aggregated over Frames and over Tracks:
              .. image:: Agg_frames_tracks.png
              

          COMMAND EXAMPLE: ::
       
              python Plotting_Eval_metrics.py --evaldirs /home/nnanos/Desktop/Spectrograms_STFT_scipy/evaldir_orig_BSS_eval , /home/nnanos/Desktop/Spectrograms_STFT_librosa/evaldir_orig_BSS_eval


          ARGUMENTS EXPLANATION:   
          
              * evaldirs: 
                     The Paths of the dirs that contains the output of the previous script (evaluation.py). It may be multiple paths (as indicated in the example above) in case you want compare multiple methods (possibly different models trained possibly with different Front-Ends).

       |
       |


#. INFERENCE-----------------------------------------------------------------------------------------  

       After you have finished with the training of your model you can directly use your model to perform a separation to an arbitrary wav file which either       is on your PC (local) or provide a url from youtube and perform separation on a youtube track of your preference. The input wav will be resampled at the sampling rate that the model where trained and the processing will be done in a block-wise fashion where the blocks will be of duration seq-dur (the seq-dur that was used to train the model). 

          COMMAND EXAMPLE: ::

              python perform_sep.py --Model_dir /home/nnanos/OPEN_UMX_LIKE_scripts/Spectrograms_NSGT_CQT_mine_24_bass/pretr_model --out_filename /home/nnanos/Desktop/tst.wav




          ARGUMENTS EXPLANATION:   
          
              * Model_dir:
                     It is the PATH for the dir that contains all the necessary files for the pretrained model.
                (it have to be the same as the output argument of the train.py script)

              * out_filename: 
                     It is the PATH of the wav file (which is created if not exists) in which the output of the model will get saved:
                         
                     
         |
         |
                     
         USING THE PRETRAINED MODELS THAT I HAVE TRAINED IN MY EXPERIMENTS:

       |
       |
   

Software License
============

Free software: MIT license
============
