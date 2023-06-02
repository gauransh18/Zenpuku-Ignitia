try:
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
