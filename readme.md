This repository contained analysis tool of text found in English translation of Chinese fantasy novels and light novels posted in WuxiaWorld.
All text data belong to [WuxiaWorld](https://www.wuxiaworld.com).

# How to use?
All scripts are located in [script/](https://github.com/simvudh/WuxiaWorldTextAnalyser/tree/master/script) directory. Run the scripts in the following order:

* Sample text extraction: [textSample_extraction.m](https://github.com/simvudh/WuxiaWorldTextAnalyser/blob/master/script/textSample_extraction.m)
  Set novel ID [Line 12](https://github.com/simvudh/WuxiaWorldTextAnalyser/blob/master/script/textSample_extraction.m#L12) and run once to extract text and store in [text_sample/](https://github.com/simvudh/WuxiaWorldTextAnalyser/tree/master/text_sample) directory.
  Alternatively, already extracted sample text in the directory can also be use.
  
* Choose novel title [Line 3](https://github.com/simvudh/WuxiaWorldTextAnalyser/blob/master/script/textSample.m#L3) to use for network training in [textSample.m](https://github.com/simvudh/WuxiaWorldTextAnalyser/blob/master/script/textSample.m).
  This script will be load in the subsequent script execution to take the sample text from [text_sample/](https://github.com/simvudh/WuxiaWorldTextAnalyser/tree/master/text_sample) directory.
  
* Train LSTM network to generate text word-by-word: [LSTMnet_train.m](https://github.com/simvudh/WuxiaWorldTextAnalyser/blob/master/script/LSTMnet_train.m)
  The trained network will be save in [trained_network_sample/](https://github.com/simvudh/WuxiaWorldTextAnalyser/tree/master/trained_network_sample) directory.
  
* Generate new text based on trained network: [textGenerator.m](https://github.com/simvudh/WuxiaWorldTextAnalyser/blob/master/script/textGenerator.m).

* [Optional] If the network training was interrupted, run [LSTMnet_train_resume.m](https://github.com/simvudh/WuxiaWorldTextAnalyser/blob/master/script/LSTMnet_train_resume.m) to resume the training.
  You can reduce the maximum number of epochs and adjust other training options, such as the initial learning rate.
  
* [Optional] Word cloud chart can be generated with [textWordCloud.m](https://github.com/simvudh/WuxiaWorldTextAnalyser/blob/master/script/textWordCloud.m).
  The generated image will be save in [images/](https://github.com/simvudh/WuxiaWorldTextAnalyser/tree/master/images) directory.
  
# Examples
* A World Eternal word cloud chart:
  ![Image of AWE](/images/a_will_eternal.jpg)
* Rebirth of the Thief who Roamed the World:
  ![Image of RoTWRTW](/images/rebirth_of_the_thief_who_roamed_the_world.jpg) 
