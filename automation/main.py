from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time

options = Options()
options.binary_location = '/home/Sam/Documents/chrome-linux64/chrome'


service = Service(executable_path="chromedriver")
driver = webdriver.Chrome(options=options, service=service)



driver.get("https://google.com")

WebDriverWait(driver, 5).until(
    EC.presence_of_element_located((By.CLASS_NAME, "gLFyf" ))
)


input_element = driver.find_element(By.CLASS_NAME, "gLFyf")
input_element.send_keys("cookie clicker" + Keys.ENTER)

WebDriverWait(driver, 100).until(
    EC.presence_of_element_located((By.PARTIAL_LINK_TEXT, "Cookie Clicker" ))
)

link = driver.find_element(By.PARTIAL_LINK_TEXT, "Cookie Clicker")
link.click()

WebDriverWait(driver, 100).until(
    EC.presence_of_element_located((By.ID, "langSelect-EN" ))
)

eng = driver.find_element(By.ID, "langSelect-EN")
eng.click()

WebDriverWait(driver, 100).until(
    EC.presence_of_element_located((By.ID, "bigCookie" ))
)

cookie = driver.find_element(By.ID, "bigCookie")

for i in range(1000) :
    cookie.click()


time.sleep(100)



driver.quit()