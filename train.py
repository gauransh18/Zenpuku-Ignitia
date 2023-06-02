import nltk
from nltk.stem.lancaster import LancasterStemmer
stemmer = LancasterStemmer()
nltk.download('punkt')
from nltk_utils import tokenize, stem, bag_of_words
import numpy as np
import tensorflow as tf
import random
from model import model_

import json
with open('intents.json') as json_data:
    intents = json.load(json_data)

#print(intents)

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


    training.append([bag, output_row])

random.shuffle(training)
training = np.array(training)


train_x = list(training[:,0])
train_y = list(training[:,1])

model_(train_x,train_y)



