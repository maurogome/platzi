import requests
from bs4 import BeautifulSoup

def main(soup):
    hot_sections = [section.a.get('href') for section in soup.find('ul', attrs = {'class' : 'hot-sections'}).find_all('li')]
    link_list = _extract_links(hot_sections)
    for link in link_list: print(link)


def _extract_links(hot_sections):
    
    link_list = []
    for link in hot_sections:
        sec_response = requests.get(link)
        sec_soup = BeautifulSoup(sec_response.text, 'lxml')
        sec_soup.encoding = 'utf-8'
        featured_article = None
        try:
            featured_article = sec_soup.find('div', attrs = {'class' : 'featured-article__container'}).a.get('href')
            link_list.append(featured_article)
        except AttributeError:
            print('Warning: featured article not found')
        
        news_links = [article_link.a.get('href') for article_link in sec_soup.find('ul', attrs = {'class' : 'article-list'}).find_all('h2')]
        for link in news_links: link_list.append(link)

    return link_list




if __name__ == '__main__':

    url = 'https://www.pagina12.com.ar/'
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'lxml')
    soup.encoding = 'utf-8'
    main(soup)
