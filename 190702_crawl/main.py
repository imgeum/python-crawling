import requests
from bs4 import BeautifulSoup

def get_html(url):
    _html = ""
    resp = requests.get(url)
    if resp.status_code == 200:
        _html = resp.text
    return _html

# iframe 'comment' src
url = 'https://comic.naver.com/comment/comment.nhn?titleId=703852&no=68&weekday=tue'
html = get_html(url)
soup = BeautifulSoup(html, 'html5lib')

