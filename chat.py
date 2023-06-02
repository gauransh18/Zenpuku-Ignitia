import model
import nltk
import model
import tensorflow as tf
from nltk_utils import bag_of_words
from keras.models import load_model

# model = load_model('model.tflearn')
myModel = tf.keras.models.load_model("model.tflearn")

def chat(words):
    print("start talking!")
    while True:
        inp = input("You: ")
        if inp.lower == "quit":
            break

        model.predict([bag_of_words(inp,words)])
