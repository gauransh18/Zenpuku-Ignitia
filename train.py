import nltk

from nltk.stem.lancaster import LancasterStemmer
stemmer = LancasterStemmer()
nltk.download('punkt')
from nltk_utils import tokenize, stem, bag_of_words
import numpy as np
import tensorflow as tf
import random
from model import model_
import pickle
import tflearn
# tf.compat.v1.logging.set_verbosity(tf.compat.v1.logging.ERROR)
# tf.logging.set_verbosity(tf.logging.ERROR)

import json
with open('intents.json') as json_data:
    intents = json.load(json_data)

# print(intents)
# try:
#     with open("data.pick",'rb') as f:
#         words,tags,training,output = pickle.load()
# except:
words = []
tags = []
documents = []
ignore = ['?','!','.',',']

for intent in intents['intents']:
    for pattern in intent['patterns']:
        w = tokenize(pattern)
        words.extend(w)
        documents.append((w, intent['tag']))
        if intent['tag'] not in tags:
            tags.append(intent['tag'])

words = [stem(w) for w in words if w not in ignore]
words = sorted(list(set(words)))
tags = sorted(list(set(tags)))

# print(tags)
# print (len(documents), "documents")
# print (len(tags), "classes", tags)
# print (len(words), "unique stemmed words", words)


training = []
output = []

output_empty = [0] * len(tags)


for doc in documents:

    bag = []
    pattern_words = doc[0]
    # bag_of_words(tokenized_sentence, words)
    pattern_words = [stemmer.stem(word.lower()) for word in pattern_words]
    for w in words:
        bag.append(1) if w in pattern_words else bag.append(0)

    output_row = list(output_empty)
    output_row[tags.index(doc[1])] = 1


    training.append(bag)
    output.append(output_row)

#random.shuffle(training)
training = np.array(training)
output = np.array(output)


train_x = list(training[:,0])
train_y = list(training[:,1])

with open("data.pick",'wb') as f:
    pickle.dump((words,tags,training,output),f)


net = model_(train_x,train_y)

model = tflearn.DNN(net, tensorboard_dir='tflearn_logs')
model.fit(training, output, n_epoch=1000, batch_size=8, show_metric=True)
model.save('model.tflearn')

# try:
#     model.load("model.tflearn")
# except:

# # Start training (apply gradient descent algorithm)
#     model.fit(train_x, train_y, n_epoch=1000, batch_size=8, show_metric=True)
#     model.save('model.tflearn')

# def chat():
#     print("start talking!")
#     flag = True
#     while(flag):
#         inp = input("You: ")
#         if inp.lower() == "quit":
#             flag = False

#         results = model.predict([bag_of_words(inp,words)])
#         results_index = np.argmax(results)
#         tag_temp = tags[results_index]
#         for tg in intents["intents"]:
#             if tg ['tag'] == tag_temp: 
#                 responses = tg['responses']
                 
#         print(random.choice(responses)) 
# chat()
