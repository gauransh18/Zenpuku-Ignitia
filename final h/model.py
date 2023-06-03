import tensorflow 
from tensorflow import keras
import numpy as np
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Input, Embedding, LSTM, LayerNormalization, Dense, Dropout
from tensorflow.keras.utils import plot_model

def neural_net(X,vacab_size,y):
    model = Sequential()
    model.add(Input(shape=(X.shape[1])))
    model.add(Embedding(input_dim=vacab_size+1, output_dim=100, mask_zero=True))
    model.add(LSTM(32, return_sequences=True))
    model.add(LayerNormalization())
    model.add(LSTM(32, return_sequences=True))
    model.add(LayerNormalization())
    model.add(LSTM(32))
    model.add(LayerNormalization())
    model.add(Dense(128, activation="relu"))
    model.add(LayerNormalization())
    model.add(Dropout(0.2))
    model.add(Dense(128, activation="relu"))
    model.add(LayerNormalization())
    model.add(Dropout(0.2))
    model.add(Dense(len(np.unique(y)), activation="softmax"))
    model.compile(optimizer='adam', loss="sparse_categorical_crossentropy", metrics=['accuracy'])

    return model

