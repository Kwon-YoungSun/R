## 4-2. 데이터 입력해 데이터 프레임 만들기
# 1. 변수 만들기
english <- c(90, 80, 60, 70)  # 영어 점수 변수 생성
english

math <- c(50, 60, 100, 20)    # 수학 점수 변수 생성
math

# 2. 데이터 프레임 만들기
# 데이터 프레임을 만들 때는 data.frame을 이용한다. 데이터 프레임을 구성할 변수를 괄호 안에 쉼표로 나열하면 된다.
# english, math로 데이터 프레임 생성해서 df_midterm에 할당
df_midterm <- data.frame(english, math)
df_midterm

# 3. 학생의 반에 대한 정보가 추가된 데이터 프레임 만들기
class <- c(1, 1, 2, 2)
class

df_midterm <- data.frame(english, math, class)
df_midterm

# 4. 분석하기
# $는 데이터 프레임 안의 변수를 지정할 때 사용되는 기호
mean(df_midterm$english)  # df_midterm의 english로 평균 산출
mean(df_midterm$math)     # df_midterm의 math로 평균 산출

# 5. 데이터 프레임 한 번에 만들기
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

# --------------------------------------------------------------------------------------------------------------------------
# Q1. data.frame()과 c()를 조합해 표의 내용을 데이터 프레임으로 만들어 출력해보기(p.88)
product <- c("사과", "딸기", "수박")
price <- c(1800, 1500, 3000)
sales <- c(24, 38, 13)

fruits_data <- data.frame(product, price, sales)
fruits_data

# Q2. 앞에서 만든 데이터 프레임을 이용해 과일 가격 평균, 판매량 평균을 구해 보세요.
mean(fruits_data$price)
mean(fruits_data$sales)

# --------------------------------------------------------------------------------------------------------------------------
## 4-3. 외부 데이터 이용하기
# 4-3-1. 엑셀 파일 불러오기
# readx1 패키지에서 제공하는 read_excel()을 이용해 엑셀 파일을 불러옵니다.
install.packages("readxl")
library(readxl)

# R에서는 파일명을 지정할 때 항상 앞뒤에 따옴표를 넣는다. 또한 확장자까지 기입한다.
df_exam <- read_excel("source/excel_exam.xlsx")  # 엑셀 파일을 불러와 df_exam에 할당

df_exam     # 출력

# 분석하기
mean(df_exam$english)
mean(df_exam$science)

# ** 엑셀 파일 첫 번째 행이 변수가 아닌 경우 : col_names = F 파라미터 설정
# 첫 번째 행을 변수명이 아닌 데이터로 인식해 불러오고 변수명은 '...숫자'로 자동 지정된다.
# F는 반드시 대문자로 입력해야됨에 유의하자.
df_exam_novar <- read_excel("source/excel_exam_novar.xlsx", col_names = F)
df_exam_novar

# 엑셀 파일에 시트가 여러 개 있는 경우 : sheet 파라미터를 이용해 몇 번째 시트의 데이터를 불러올지 지정할 수 있음
# 엑셀 파일의 세 번째 시트에 있는 데이터 불러오기
df_exam_sheet <- read_excel("source/excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet

# --------------------------------------------------------------------------------------------------------------------------
# 4-3-2. CSV 파일 불러오기
# read.csv() 이용
df_csv_exam <- read.csv("D:/R/Doit_R-master/Data/csv_exam.csv")
df_csv_exam

# 분석하기
mean(df_exam$english)
mean(df_exam$science)

# ** 문자가 들어 있는 파일을 불러올 때 : stringAsFactors = F 파라미터 설정
# 변수를 factor 타입이 아닌 문자 타입으로 불러오기 때문에 오류가 발생하지 않음.
df_csv_exam <- read.csv("D:/R/Doit_R-master/Data/csv_exam.csv", stringsAsFactors = F)
df_csv_exam

# 4-3-3. 데이터프레임을 CSV 파일로 저장하기
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

# 저장한 파일은 프로젝트 폴더에 생성됨
write.csv(df_midterm, file = "df_midterm.csv")

# --------------------------------------------------------------------------------------------------------------------------
# 4-3-3. RDS 파일 활용하기
# RDS는 R 전용 데이터 파일로, 다른 파일들에 비해 R에서 읽고 쓰는 속도가 빠르고 용량이 작음.

# 데이터 프레임을 RDS 파일로 저장하기 : saveRDS
saveRDS(df_midterm, file = "df_midterm.rds")

# RDS 파일 불러오기
rm(df_midterm)  # 데이터 삭제

df_midterm      # 데이터가 없으므로 에러 출력

df_midterm <- readRDS("df_midterm.rds")
df_midterm

# --------------------------------------------------------------------------------------------------------------------------
# 참고 : RDA 파일 다루기
load("df_minterm.rda")  # Rda 파일 불러오기
save(df_minterm, file = "df_minterm.rda")

