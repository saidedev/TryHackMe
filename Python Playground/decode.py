def text_to_unicode(string):
    uni=[]
    for char in string:
         a=ord(char)
         a -= 97
         uni.append(str(a))
    return uni

def unicode_to_text(string):
    out=""
    for char in range(0,len(string),2):
         a = int(string[char])
         b = int(string[char +1])
         temp = a * 26
         temp += b
         out += chr(temp)
    return out

if __name__ == "__main__":
     hash="dxeedxebdwemdwesdxdtdweqdxefdxefdxdudueqduerdvdtdvdu"
     stri1 = text_to_unicode(hash)
     stri2 = unicode_to_text(stri1)
     stri3 = text_to_unicode(stri2)
     password = unicode_to_text(stri3)
     print(password)
