import nltk
from nltk.stem.lancaster import LancasterStemmer
stemmer = LancasterStemmer()
nltk.download('punkt')
from nltk_utils import tokenize, stem, bag_of_words
import numpy as np
import tensorflow as tf
import random

import json
with open('intents.json') as json_data:
    intents = json.load(json_data)

#print(intents)

words = []
tags = []
documents = []
ignore = ['?']

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

print (len(documents), "documents")
print (len(tags), "classes", tags)
print (len(words), "unique stemmed words", words)