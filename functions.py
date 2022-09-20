# %% KeySmash detector Jrrhack
# version v0.1 2022-09-18

# returns a dictionary with the letters and its repetition count
def repetition_amount(string):
    repetition_dict = dict()

    # check letter by letter in a string
    for letter in string:
        if letter in repetition_dict:
            # if its a repetition, adds up
            repetition_dict[letter] += 1
        else:
            # else adds the new letter into the dict
            repetition_dict.update({letter: 1})
    return repetition_dict

# %%
# Returns the pattern Dict of amount and repetitions of that pattern

def common_patterns(string, filename):
    import re

    pattern_match = dict()

    # Read list of known words into list
    with open(filename) as file:
        lines = file.readlines()

        # Remove linebreaks
        lines = [line.rstrip() for line in lines]

    for l in lines:
        # find how many patter repetitions in string
        results = len(re.findall(l, string, re.IGNORECASE))
        if results > 0:
            pattern_match.update({l: results})

    return pattern_match

# %%
# counts the number of vowels in a string

def vowel_count(string):
    import re

    vowel_count = 0

    for s in string:
        if len(re.findall(r"(a|e|i|o|u)", s, re.IGNORECASE)) > 0:
            vowel_count += 1
    return vowel_count

# %%

# returns TRUE if the string has a higher percentage of repetitions to be considered keymash and has some common words in it, adds a comment and score
def isKeySmash(string, int_repetition_percent, int_vowel_percent):

    # amount of different letters and count
    r1_repetition = repetition_amount(string)
    r2_pattern = common_patterns(string, "common.txt")
    r3_vowel = vowel_count(string)
    score = 0
    score_board = {
        -1: [False, "Nah, a lot of vowels, low score"],
        0: [False, "hmm.. meh, Low score"],
        1: [True, "Less likely but possible, But I miss some vowels in there"],
        2: [True, "Somewhat possible, lots of vowels and repetitions"],
        3: [True, "Possible, But theres too many repeated letters"],
        4: [True, "Probable, Lacks some vowels, and theres a lot of repetitions"],
        5: [True, "Very Probable, Theres some known clichet in there"],
        6: [True, "Almost certain, Known clichet and too little vowels"],
        7: [True, "Clichet, many vowels and repetitions "],
        8: [True, "Certain, Known clichet and repetitions"],
        10: [True, "Absolute, Known clichet and repetitions, too few vowels"]
    }

    # if theres too many repetitions adds to the score
    if len(r1_repetition) < (len(string)/(100/int_repetition_percent)):
        score += 3  # mepetition means much
    if len(r2_pattern) > 0:
        score += 5  # known words means a lot
    # if theres less vowels than the % set
    if r3_vowel < (len(string)/(100/int_vowel_percent)):
        score += 1  # vowels means a bit
    else:
        score -= 1

    for sb in score_board:
        if score == sb:
            return score_board[score][0], score_board[score][1],  score
    return score_board[-1][0], score_board[-1][1],  score

# %%
