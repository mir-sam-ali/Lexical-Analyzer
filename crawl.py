import os
import urllib.request as urllib2
from bs4 import BeautifulSoup

url = "https://docs.oracle.com/javase/tutorial/java/nutsandbolts/_keywords.html"

page = urllib2.urlopen(url)

soup = BeautifulSoup(page, "html.parser")

table = soup.find('table')

td_list = table.findAll('td')

with open('keywords.txt', 'w') as fp:
    keywords = []
    i = 1
    for td in td_list:
        fp.write('"'+td.text.strip("*")+'" | ')
        i += 1
        if i % 5 == 0:
            fp.write('\n')
        print('"'+td.text.strip("*")+'"')
        keywords.append(td.text.strip("*"))

print(len(keywords))
