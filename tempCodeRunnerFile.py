pattern_words = [stemmer.stem(word.lower()) for word in pattern_words]
    # for w in words:
    #     bag.append(1) if w in pattern_words else bag.append(0)

    # output_row = list(output_empty)
    # output_row[tags.index(doc[1])] = 1