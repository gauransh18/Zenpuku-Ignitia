import tensorflow as tf
import nltk
nltk.download('punkt')
import tflearn

def model_(training,output):
    tf.compat.v1.reset_default_graph()
    net = tflearn.input_data(shape=[None, len(training[0])])
    net = tflearn.fully_connected(net, 8)
    net = tflearn.fully_connected(net, 8)
    net = tflearn.fully_connected(net, len(output[0]), activation='softmax')
    net = tflearn.regression(net)
    
    return net
    # Define model and setup tensorboard
    # model = tflearn.DNN(net, tensorboard_dir='tflearn_logs')

    # try:
    #     model.load("model.tflearn")
    # except:

    # # Start training (apply gradient descent algorithm)
    #     model.fit(train_x, train_y, n_epoch=1000, batch_size=8, show_metric=True)
    #     model.save('model.tflearn')

