#-*- coding: utf-8 -*-
import requests
from bs4 import BeautifulSoup
from datetime import datetime
import csv


def get_html(url):
    _html_list = ""
    resp = requests.get(url)
    
    if resp.status_code == 200:
        _html = resp.text
    
    return _html


def get_cmt_dict_list(html):
    soup = BeautifulSoup(html, 'html5lib')
    reple_items = soup.find('div', {'class':'score_result'}).find_all('li')
    cmt_dict_list = []

    for item in reple_items:
        star_score = int(item.find('em').text)
        cmt = item.find('p').text
        date = datetime.strptime(item.find_all('em')[2].text, '%Y.%m.%d %H:%M').date()
        #like = item.find_all('span')[4].text
        #dislike = item.find_all('span')[6].text
        
        cmt_dict = {'star':star_score, 'date':date, 'cmt':cmt}
        cmt_dict_list.append(cmt_dict)

    return cmt_dict_list


def get_cmt(html):
    soup = BeautifulSoup(html, 'html5lib')
    reple_items = soup.find('div', {'class':'score_result'}).find_all('li')
    cmt_list = []

    for item in reple_items:
        cmt = item.find('p').text
        cmt_list.append(cmt)
    
    return cmt_list

def main():
    # Movie Captain Marvel
    cmt_dict_list_data = []
    csv_columns=['star', 'date', 'cmt']
    base_url = 'https://movie.naver.com//movie/bi/mi/pointWriteFormList.nhn?code=132623&type=after&page='
    
    # 3607
    for page_num in range(1, 10):
        html = get_html(base_url + str(page_num))
        cmt_dict_list = get_cmt_dict_list(html)
        cmt_dict_list_data.extend(cmt_dict_list)
        print(str(page_num) + 'page')
        url = base_url + str(page_num)

    try:
        with open('./movie_comment.csv', 'w', encoding='utf-8') as file:
            writer = csv.DictWriter(file, fieldnames=csv_columns)
            writer.writeheader()
            for data in cmt_dict_list_data:
                writer.writerow(data)
    except IOError:
        print("IO Error")


if __name__ == '__main__':
    main()
