def count_word_occurrences(text, word):
    # Convert the text to lowercase and split it into words
    cleaned_text = ''.join(char.lower() if char.isalnum() or char.isspace() else ' ' for char in text)
    words = cleaned_text.split()
    
    # Count the occurrences of the specific word
    count = words.count(word.lower())
    
    return count

# Input text
text = """The University of Hawaii began using radio to send digital information as early as 1971,using ALOHAnet. 
Friedhelm Hillebrand conceptualised SMS in 1984 while working for Deutsche Telekom. Sitting at a typewriter at home, 
Hillebrand typed out random sentences and counted every letter, number, punctuation, and space. 
Almost every time, the messages contained fewer than 160 characters, thus giving the basis for the 
limit one could type via text messaging. With Bernard Ghillebaert of France Télécom, he developed 
a proposal for the GSM (Groupe Spécial Mobile) meeting in February 1985 in Oslo. 
The first technical solution evolved in a GSM subgroup under the leadership of Finn Trosby. 
It was further developed under the leadership of Kevin Holley and Ian Harris (see Short Message Service). 
SMS forms an integral part of SS7 (Signalling System No. 7). Under SS7, it is a "state" with a 160 character data, 
coded in the ITU-T "T.56" text format, that has a "sequence lead in" to determine different language codes, 
and may have special character codes that permits, for example, sending simple graphs as text. 
This was part of ISDN (Integrated Services Digital Network) and since GSM is based on this, 
made its way to the mobile phone. Messages could be sent and received on ISDN phones, 
and these can send SMS to any GSM phone. The possibility of doing something is one thing, 
implementing it another, but systems existed from 1988 that sent SMS messages to mobile phones (compare ND-NOTIS)."""

# Call the function for "the"
word_to_count = "the"
count = count_word_occurrences(text, word_to_count)

print(f"The word '{word_to_count}' appears {count} times in the text.")