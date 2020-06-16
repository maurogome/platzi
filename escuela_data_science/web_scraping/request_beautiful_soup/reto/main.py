import requests
import pandas as pd
from bs4 import BeautifulSoup
import logging

logging.basicConfig(level = logging.INFO)
logger = logging.getLogger(__name__)

def main(soup):
    hot_sections = [section.a.get('href') for section in soup.find('ul', attrs = {'class' : 'hot-sections'}).find_all('li')]
    link_list = _extract_links(hot_sections)
    scrapped_data = _extract_data(link_list)
    df = pd.DataFrame(scrapped_data, index = len(scrapped_data))
    #df = df.head()
    df.to_csv('Pagina12_data.csv')
        
def _extract_links(hot_sections):
    
    link_list = []
    for link in hot_sections:
        logger.info('\n\nExtracting links for {} section'.format(link))
        sec_response = requests.get(link)
        sec_response.encoding = 'latin'
        if sec_response.status_code == 200:
            sec_soup = BeautifulSoup(sec_response.text, 'lxml')
            featured_article = None
            try:
                featured_article = sec_soup.find('div', attrs = {'class' : 'featured-article__container'}).a.get('href')
                link_list.append(featured_article)
            except AttributeError as e:
                logger.warning('Warning: featured article not found at \n >>> {}'.format(link), exc_info = False)
                print('\n\n')
        
            news_links = [article_link.a.get('href') for article_link in sec_soup.find('ul', attrs = {'class' : 'article-list'}).find_all('h2')]
            for link in news_links: 
                link_list.append(link)
                logger.info('Link found: {}'.format(link))
        else:
            logger.warning('Error: Status code = {}'.format(sec_response.status_code))

    logger.info('\n{} links found for {}'.format(len(link_list), url))

    return link_list

def _extract_data(link_list):

    logger.info('\nStrating to scrape data from {}\n\n'.format(url))
    
    scrapped_data = []
    data = {}
    
    for i, link in enumerate(link_list):
        logger.info('Extracting data from link {}/{}'.format(i + 1, len(link_list)))
        
        data = {'url':url}
        try: 
            last_response = requests.get(link)
            last_response.encoding = 'latin'

        except Exception as e:
            
            logger.warning('Error: {}'.format(e))
        
        if last_response.status_code == 200:
            last_soup = BeautifulSoup(last_response.text, 'lxml')

            date = last_soup.find('span', attrs = {'pubdate':'pubdate'})
            if date:
                data['date'] = date.get('datetime')
            else:
                date['date'] = None
                logger.warning('Did not find date for {}'.format(link))

            title = last_soup.find('h1', attrs = {'class':'article-title'})
            if title:
                data['title'] = title.text
            else:
                data['title'] = None
                logger.warning('Did not find title for {}'.format(link))

            body = last_soup.find('div', attrs = {'class':'article-text'})
            if body:
                data['body'] = body.text
            else:
                data['body'] = None
                logger.warning('Did not found body for {}'.format(link))

        else:
            logger.warning('Error: Status code = {}'.format(last_response.status_code))

        scrapped_data.append(data)

    return data

if __name__ == '__main__':

    url = 'https://www.pagina12.com.ar/'
    logger.info('Starting scraping for {}'.format(url))
    response = requests.get(url)
    response.encoding = 'latin'
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'lxml')
        main(soup)
    else:
        logger.warning('Error: Status code = {}'.format(response.satus_code))
