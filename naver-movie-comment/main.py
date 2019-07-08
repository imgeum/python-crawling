import requests
from bs4 import BeautifulSoup
import csv

def get_html(url):
    _html = ""
    resp = requests.get(url)
    
    if resp.status_code == 200:
        _html = resp.text
    else:
        return False
    
    return _html


def get_comment_list(html):
    soup = BeautifulSoup(html, 'html5lib')
    reple_items = soup.find('div', {'class':'score_result'}).find_all('li')
    comment_list = []

    for item in reple_items:
        star_score = item.find('em').text
        comment = item.find('p')
        date = item.find_all('em')[2].text
        '''
        like = item.find_all('span')[4].text
        dislike = item.find_all('span')[6].text
        '''
        comment_data_dict = {'star':star_score, 'cmt':comment, 'date':date}
        comment_list.append(comment_data_dict)

    return comment_list

def save_to_csv(comment_list):
    file = open('movie_comment.csv', 'w', encoding='utf-8', newline='')
    csvfile = csv.writer(file)
    for row in comment_list:
        csvfile.writerow(row)
    file.close

def main():
    # Movie Captain Marvel
    comment_list = []

    base_url = 'https://movie.naver.com//movie/bi/mi/pointWriteFormList.nhn?code=132623&type=after&page='
    page_num = 1
    url = base_url + str(page_num)

    while get_html(url):
        html = get_html(url)
        comment_list_item = get_comment_list(html)
        comment_list.append(comment_list_item)
        print(str(page_num) + ' page ')
        page_num += 1
        url = base_url + str(page_num)

    save_to_csv(comment_list)
        
if __name__ == '__main__':
    main()