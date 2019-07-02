import requests
from bs4 import BeautifulSoup

def get_html(url):
    _html = ""
    resp = requests.get(url)
    if resp.status_code == 200:
        _html = resp.text
    return _html

url = "https://comic.naver.com/webtoon/detail.nhn?titleId=703852&no=68&weekday=tue"
cmt_url = '/comment/comment.nhn?titleId=703852&no=68'
html = get_html(url + cmt_url)
soup = BeautifulSoup(html, 'html5lib')
soup = BeautifulSoup(html, 'html.parser')
comment = soup.find("ul", {"class":"img_list"}
        ).find_all("div", {"class":"thumb"})

for webtoon in webtoons:
    info_soup = webtoon.find("img")
    _title = info_soup["title"]
    print(_title)