# 5-1. 데이터 파악하기
exam <- read.csv("D:/R/Doit_R-master/Data/csv_exam.csv")
exam

# 1. head() - 데이터의 앞부분 확인하기
head(exam)      # 앞에서부터 6행까지 출력

head(exam, 10)  # 앞에서부터 10행까지 출력

# 2. tail() - 데이터 뒷부분 확인하기
tail(exam)      # 뒤에서부터 6행까지 출력

tail(exam, 10)  # 뒤에서부터 10행까지 출력력

# 3. View() - 뷰어 창에서 데이터 확인하기
# View()에서 맨 앞의 V는 대문자로 입력해야 한다.
View(exam)

# 4. dim() - 데이터가 몇 행, 몇 열로 구성되어 있는지 알아보기
dim(exam)

# 5. str() - 데이터에 들어 있는 변수들의 속성 파악하기
str(exam)

# 6. summary() - '평균'처럼 변수의 값을 요약한 요약 통계량 산출하기
summary(exam)   # 요약 통계량 출력

#----------------------------------------------------------------------------------------
# 출력값            통계량                                      설명
#----------------------------------------------------------------------------------------
# Min         최솟값(Minimum)                 가장 작은 값
# 1st Qu      1사분위수(1st Quantile)         하위 25%(4분의 1) 지점에 위치하는 값
# Median      중앙값(Median)                  중앙에 위치하는 값
# Mean        평균(Mean)                      모든 값을 더해 값의 개수로 나눈 값
# 3rd Qu      3사분위수(3rd Quantile)         하위 75%(4분의 3) 지점에 위치하는 값
# Max         최댓값(Maximum)                 가장 큰 값
#----------------------------------------------------------------------------------------


#----------------------------------------------------------------------------------------
# mpg 데이터 파악하기
# ggplot2의 mgs 데이터를 데이터 프레임 형태로 불러오기
mpg <- as.data.frame(ggplot2::mpg)
head(mpg)
tail(mpg)

View(mpg)

dim(mpg)
str(mpg)
?mpg


summary(mpg)  # 요약 통계량 출력
# 숫자로 된 변수는 여섯 가지 요약 통계량을 부여 주고, 문자로 된 변수는 요약 통계량을 계산할 수 없으니 값의 개수와 변수의 속성을 보여줌

# manufacturer          model               displ            year           cyl           trans               drv           
# Length:234         Length:234         Min.   :1.600   Min.   :1999   Min.   :4.000   Length:234         Length:234        
# Class :character   Class :character   1st Qu.:2.400   1st Qu.:1999   1st Qu.:4.000   Class :character   Class :character  
# Mode  :character   Mode  :character   Median :3.300   Median :2004   Median :6.000   Mode  :character   Mode  :character  
# Mean   :3.472   Mean   :2004   Mean   :5.889                                        
# 3rd Qu.:4.600   3rd Qu.:2008   3rd Qu.:8.000                                        
# Max.   :7.000   Max.   :2008   Max.   :8.000                                        
# cty             hwy             fl               class          
# Min.   : 9.00   Min.   :12.00   Length:234         Length:234        
# 1st Qu.:14.00   1st Qu.:18.00   Class :character   Class :character  
# Median :17.00   Median :24.00   Mode  :character   Mode  :character  
# Mean   :16.86   Mean   :23.44                                        
# 3rd Qu.:19.00   3rd Qu.:27.00                                        
# Max.   :35.00   Max.   :44.00 

# ================================================================================================================================
# 5-2. 변수명 바꾸기

# 1) 2개의 변수로 된 데이터 프레임 생성
df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 2))
df_raw

# 2) rename()을 이용하기 위해 dplyr 패키지를 설치하고 로드하기
install.packages("dplyr")
library(dplyr)

# 3) 데이터 프레임 복사본 만들기
df_new <- df_raw
df_new

# 4) 변수명 바꾸기
# rename(데이터 프레임명, 새 변수명 = 기존 변수명) 
# 순서가 바뀌면 실행되지 않으니 유의한다.
df_new <- rename(df_new, v2 = var2)   # var2를 v2로 수정
df_new

df_raw
df_new

# --------------------------------------------------------------------------------------------------------------------------------
# 예제 ] mpg 데이터의 변수명을 이해하기 쉬운 단어로 바꿔라.
# Q1. ggplot2() 패키지의 mpg 데이터를 사용할 수 있도록 불러온 후 복사본을 만들어라.
# mpg 데이터 불러오기
mpg <- as.data.frame(ggplot2::mpg)
mpg

# mpg 데이터 복사본 만들기 
mpg2 <- mpg

# Q2. 복사본 데이터를 이용해 cty는 city로, hwy는 highway로 수정하라.
# city는 city로 수정
mpg2 <- rename(mpg2, city = cty)
mpg2

# hwy는 highway로 수정
mpg2 <- rename(mpg2, highway = hwy)
mpg2

# Q3. 데이터 일부를 출력해 변수명이 바뀌었는지 확인해 보라.
head(mpg2)

# ================================================================================================================================
# 5-3. 파생변수 만들기
# 파생변수란(Derived Variable)? : 기존의 변수를 변형해 만든 함수

## 변수 조합해 파생변수 만들기
# 1) 2개의 변수로 구성된 데이터 프레임 생성
df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))

df$var_sum <- df$var1 + df$var2
df

df$var_mean <- (df$var1 + df$var2)/2  # var_mean 파생변수 생성
df

# mpg 통합 연비 변수 만들기
mpg$total <- (mpg$cty + mpg$hwy)/2    # 통합 연비 변수 생성
head(mpg)

mean(mpg$total) # 통합 연비 변수 평균

## 조건문을 활용해 파생변수 만들기
# '조건문 함수'를 이용해 파생변수를 만들기
# 1) 기준값 정하기
summary(mpg$total)  # 요약 통계량 산출
hist(mpg$total)     # 히스토그램 생성
  
# 2) 합격 판정 변수 만들기
# ifelse(조건문, 조건에 맞을 때 부여할 값, 조건에 맞지 않을 때 부여할 값)
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail") # total이 20 이상이면 "pass"를 부여하고 그렇지 않으면 "fail"을 부여
head(mpg, 20)

# 3) 빈도표로 합격 자동차 수 살펴보기
table(mpg$test) # 연비 합격 빈도표 생성

# 4) 막대 그래프로 빈도 표현하기
library(ggplot2)  # ggplot2 로드
qplot(mpg$test)   # 연비 합격 빈도 막대 그래프 생성


# ----------------------------------------------------------------------------------------------------------------------------
## 중첩 조건문 활용하기
# ifelse() 내에 다시 ifelse()를 넣는 형식으로 조건문을 중첩해 작성함

# total을 기준으로 A, B, C 등급 부여
mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B", "C"))
head(mpg, 20)   # 데이터 확인

# 빈도표, 막대 그래프로 연비 등급 살펴보기
table(mpg$grade)  # 등급 빈도표 생성

qplot(mpg$grade)  # 등급 빈도 막대 그래프 생성


## 원하는 만큼 범주 만들기
# A, B, C, D 등급 부여
mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >= 25, "B",
                        ifelse(mpg$total >= 20, "C", "D")))

head(mpg)
table(mpg$grade2)
qplot(mpg$grade2)

# ----------------------------------------------------------------------------------------------------------------------------
# 분석 도전 ] midwest 데이터를 사용해 데이터 분석 문제를 해결하라.
# Q1, ggplot2의 midwest 데이터를 데이터 프레임 형태로 불러온 다음 데이터의 특징을 파악하세요.
library(ggplot2)

# 데이터를 프레임 형태로 불러오기
midwest <- as.data.frame(ggplot2::midwest)

?midwest

head(midwest, 5)  # 데이터 앞부분 출력
View(midwest)     # 데이터 전체 보기
dim(midwest)      # 데이터의 행 열 개수 출력 (행:437, 열:28)
str(midwest)      # 데이터 속성 출력
summary(midwest)

# Q2. poptotal(전체 인구) 변수를 total로, popasian(아시아 인구) 변수를 asian으로 수정하세요.
midwest <- rename(midwest, total = poptotal)
midwest <- rename(midwest, asian = popasian)

head(midwest)

# Q3. total, asian 변수를 이용해 '전체 인구 대비 아시아 인구 백분율' 파생변수를 만들고, 히스토그램을 만들어 도시들이 어떻게 분포하는지 살펴보세요.
midwest$percasian <- (midwest$asian / midwest$total) * 100

head(midwest)
hist(midwest$percasian)

# Q4. 아시아 인구 백분율 전체 평균을 구하고, 평균을 초과하면 "large", 그 외에는 "small"을 부여하는 파생변수를 만들어 보세요.
mean(midwest$percasian)
midwest$asianavg <- ifelse(midwest$percasian > mean(midwest$percasian), "large", "small")

# Q5. "large"와 "small"에 해당하는 지역이 얼마나 되는지 빈도표와 빈도 막대 그래프를 만들어 확인해 보세요.
table(midwest$asianavg)
qplot(midwest$asianavg)

