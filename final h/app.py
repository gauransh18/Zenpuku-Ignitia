from flask import Flask, render_template,request, jsonify
import pickle
from keras.models import load_model

from chat import chatting

from chat import get_response
app=Flask(__name__)

model = load_model('model.h5')

@app.get("/")
def index_get():
    return render_template("base.html")

@app.post("/predict")
def predict():
    text=request.get_json().get("message")
    response=chatting(text) 
    message={"answer":response}
    return jsonify(message)

if __name__ == "__main__":
    app.run(debug=True)
