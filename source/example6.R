### 자유자재로 데이터 가공하기
## 6-1. 데이터 전처리 - 원하는 형태로 데이터 가공하기
# 데이터 전처리 : 분석에 적합하게 데이터를 가공하는 방법

# dplyr : 데이터 전처리 작업에 가장 많이 사용되는 패키지
        # filter() : 행 추출
        # select() : 열(변수) 추출
        # arrange() : 정렬
        # mutate() : 변수 추가
        # summarise() : 통계치 산출
        # group_by() : 집단별로 나누기
        # left_join() : 데이터 합치기(열)
        # bind_rows() : 데이터 합치기(행)

## 6-2. 조건에 맞는 데이터만 추출하기
library(dplyr)

exam <- read.csv("D:/R/Doit_R-master/Data/csv_exam.csv")
exam

# exam에서 class가 1인 경우만 추출해 출력
# dplyr 패키지는 %>% 기호를 이용해 함수들을 나열하는 방식으로 코드 작성
# Ctrl + Shift + M을 누르면 %>%가 삽입됨.
exam %>% filter(class == 1)

# 2반인 경우만 추출
exam %>% filter(class == 2)

exam %>% filter(class != 1) # 1반이 아닌 경우

exam %>% filter(class != 3) # 3반이 아닌 경우

#-------------------------------------------------------------------------------------------------------------------------------
## 초과, 미만, 이상, 이하 조건 걸기
exam %>% filter(math > 50)  # 수학 점수가 50점을 초과한 경우

exam %>% filter(math < 50)  # 수학 점수가 50점 미만인 경우

exam %>% filter(math >= 80)  # 수학 점수가 80점 이상인 경우

exam %>% filter(english >= 80)  # 영어 점수가 80점 이상인 경우

exam %>% filter(english <= 80)  # 영어 점수가 80점 이하인 경우


## 여러 조건을 충족하는 행 추출하기
# 1반이면서 수학 점수가 50점 미만인 경우
exam %>% filter(class == 1 & math >= 50)

# 2반이면서 영어 점수가 80점 이상인 경우
exam %>% filter(class == 2 & english >= 80)
#--------------------------------------------------------------------------------------------------------------------------------


## 여러 조건 중 하나 이상 충족하는 행 추출하기
# 수학 점수가 90점 이상이거나 영어 점수가 90점 이상인 경우
exam %>% filter(math >= 90 | english >= 90)

# 영어 점수가 90점 미만이거나 과학 점수가 50점 미만인 경우
exam %>% filter(english < 90 | science < 50)

#-------------------------------------------------------------------------------------------------------------------------------
## 목록에 해당하는 행 추출하기
# %in% 기호는 변수와 같이 지정한 조건 목록에 해당하는지 확인하는 기능을 함
# 1, 3, 5번에 해당하면 추출
exam %>% filter(class == 1 | class == 3 | class == 5)

exam %>% filter(class %in% c(1, 3, 5))  # 1, 3, 5번에 해당하면 추출

## 추출한 행으로 데이터 만들기
class1 <- exam %>% filter(class == 1) # class가 1인 행 추출, class1에 할당
class2 <- exam %>% filter(class == 2) # class가 2인 행 추출, class1에 할당

mean(class1$math)
mean(class2$math)

#--------------------------------------------------------------------------------------------------------------------------------
# Question ] mpg 데이터를 이용해 분석 문제를 해결하라.
# Q1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다. displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중
#     어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보아라.
library(ggplot2)
mpg = as.data.frame(ggplot2::mpg)
?mpg

# 배기량(displ)이 4 이하인 자동차와 5 이상인 자동차만 추출
sample1 <- mpg %>% filter(displ <= 4) # 배기량이 4 이하인 자동차
View(sample1)

sample2 <- mpg %>% filter(displ >= 5) # 배기량이 5 이상인 자동차
View(sample2)

mean(sample1$hwy) # [1] 25.96319
mean(sample2$hwy) # [1] 18.07895

# ===> 따라서 배기량이 4이하인 자동차의 고속도로 연비가 더 높다.

# Q2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다. "audi"와 "toyota" 중 어느 manufacturer(자동차 제조 회사)의 cty가 평균적으로 더
#     높은지 알아보세요.
sample3 <- mpg %>% filter(manufacturer == "audi")
sample3

sample4 <- mpg %>% filter(manufacturer == "toyota")
sample4

mean(sample3$cty) # [1] 17.61111
mean(sample4$cty) # [1] 18.52941
# ===> 따라서 toyota의 cty가 평균적으로 더 높다.

# Q3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다. 이 회사들의 데이터를 추출한 후 hwy 전체 평균을 구해 보세요.
sample5 <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(sample5$hwy) # [1] 22.50943


# ======================================================================================================================================================
### 6-3. 필요한 변수만 추출하기
## 변수 추출하기
exam %>% select(math)     # math 추출

exam %>% select(english)  # english 추출

exam %>% select(class, math, english) # class, math, english 변수 추출

exam %>% select(-math)  # math 제외

exam %>% select(-math, -english)  # math, english 제외


## dplyr 함수 조합하기
# 1) filter()와 select() 조합하기
# class가 1인 행만 추출한 다음 english 추출
exam %>% filter(class == 1) %>% select(english)

# 2) 가독성 있게 줄 바꾸기
# class가 1인 행 중 english만 추출
exam %>% 
  filter(class == 1) %>%    # class가 1인 행 추출 
  select(english)           # english 추출

# 3) 일부만 출력하기
# head()를 dplyr에 조합
exam %>% 
  select(id, math) %>%      # id, math 추출
  head                      # 앞부분 6행까지 추출

exam %>% 
  select(id, math) %>%      # id, math 추출
  head(10)                  # english 추출


# ----------------------------------------------------------------------------------------------------------------------------------
# Question ] mpg 데이터를 이용해 해결하라
# Q1. mpg 데이터는 11개 변수로 구성되어 있습니다. 이 중 일부만 추출해 분석에 활용한다고 합니다. mpg 데이터에서 class(자동차 종류),
#     cty(도시 연비) 변수를 추출해 새로운 데이터를 만드세요. 새로 만든 데이터의 일부를 출력해 두 변수로만 구성되어 있는지 확인하세요.
sample6 <- mpg %>% select(class, cty)
head(sample6)

# Q2. 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다. 앞에서 추출한 데이터를 이용해 class(자동차 종류)가 "suv"인 자동차와
#     "compact"인 자동차 중 어떤 자동차의 cty(도시 연비) 평균이 더 높은지 알아보세요.
sample7 <- mpg %>% filter(class == "suv") # class is suv
sample8 <- mpg %>% filter(class == "compact") # class is compact
mean(sample7$cty) # 13.5
mean(sample8$cty) # 20.122766
#     ===> 따라서 자동차 종류가 compact인 자동차의 cty 평균이 더 높다.


# ======================================================================================================================================================
## 6-4. 순서대로 정렬하기
## 오름차순으로 정렬하기
exam %>% arrange(math)  # math 오름차순 정렬

# 내림차순으로 정렬하기
exam %>% arrange(desc(math))  # math 내림차순 정렬

exam %>% arrange(class, math) # class 및 math 오름차순 정렬, 먼저 class 기준으로 오름차순 정렬 후 수학 점수를 기준으로 오름차순 정렬해 출력

#--------------------------------------------------------------------------------------------------------------------------------------
## Question ] mpg 데이터를 이용해 분석 문제를 해결하라
# Q1. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 합니다. "audi"에서 생산한 자동차 중
#     hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.
mpg %>% filter(manufacturer == "audi") %>%  # audi 추출
        arrange(desc(hwy)) %>%              # hwy 내림차순 정렬
        head(5)                             # 5행까지 출력

# ======================================================================================================================================================
## 6-5. 파생변수 추가하기
# 1) 세 과목의 점수를 모두 합한 총합 변수를 만들어 추가한 후 일부분만 추출하기
exam %>% mutate(total = math + english + science) %>% # 총합 변수 추가
         head                                         # 일부 추출

# 2) 여러 파생변수 한 번에 추가하기
exam %>% 
  mutate(total = math + english + science,            # 총합 변수 추가
         mean = (math + english + science)/3) %>%     # 총평균 변수 추가
  head                                                # 일부 추출

# 3) mutate()에 ifelse() 적용하기
exam %>% 
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>% 
  head

# 4) 추가한 변수를 dplyr 코드에 바로 활용하기
# mutate()로 추가한 변수를 arrange()에서 기준으로 삼아 정렬해 일부 출력
exam %>% 
  mutate(total = math + english + science) %>%  # 총합 변수 추가 
  arrange(total) %>%                            # 총합 변수 기준 정렬
  head                                          # 일부 추출

# 참고 ] dplyr 함수에는 데이터 프레임명을 반복 입력하지 않는다.
#     dplyr 함수를 입력하지 않고 파생변수를 추가하는 방법은 변수명 앞에 데이터 프레임명을 반복해 입력한다.
#   예 ] df$var_sum <- df$var1 + df$var2

#--------------------------------------------------------------------------------------------------------------------------------------
# Question ] mpg 데이터를 이용해 분석 문제를 해결하라.
# Q1. mpg() 데이터 복사본을 만들고, cty와 hwy를 더한 '합산 연비 변수'를 추가하세요.
mpgcopy <- mpg %>% mutate(total = cty + hwy)  # cty와 hwy를 더한 total 열을 추가한 것을 복사

# Q2. 앞에서 만든 '합산 연비 변수'를 2로 나눠 '평균 연비 변수'를 추가하세요.
mpgcopy$avg <- mpgcopy$total / 2
head(mpgcopy)

# Q3. '평균 연비 변수'가 가장 높은 자동차 3종의 데이터를 출력하세요.
mpgcopy %>% arrange(desc(avg)) %>%  # 평균 연비 변수가 가장 높은 순서
          head(3)                   # 3순위

# Q4. 1~3번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 실행해 보세요. 데이터는 복사본 대신 mpg 원본을 이용하세요.
mpg %>% mutate(total = cty + hwy,                # '합산 연비 변수' 추가
               avg = (cty + hwy) / 2) %>%        # '평균 연비 변수' 추가
        arrange(desc(avg)) %>%                   # '평균 연비 변수' 내림차순 정렬
        head(3)                                  # 가장 높은 자동차 3종만 출력력
# ======================================================================================================================================================
## 6-6. 집단별로 요약하기
# group_by()와 summarise() 사용
# 집단 간에 어떤 차이가 있는지 쉽게 파악할 수 있음

# 1) summarise() 사용
exam %>% summarise(mean_math = mean(math)) # math 평균 산출

# 2) 집단별로 요약하기
# group_by()에 변수를 지정하면 변수 항목별로 데이터를 분리함. 여기에 summarise()를 조합하면 집단별 요약 통계량 산출함
exam %>% 
  group_by(class) %>%                      # class별로 분리
  summarise(mean_math = mean(math))        # math 평균 산출

# 3) 여러 요약 통계량 한 번에 산출하기
# n() : 데이터가 몇 행으로 되어 있는지 '빈도'를 구하는 기능을 함. 빈도수가 4이므로 반별로 네명의 학생이 있음.
exam %>% 
  group_by(class) %>%                      # class별로 분리
  summarise(mean_math = mean(math),        # math 평균
            sum_math = sum(math),          # math 합계
            median_math = median(math),    # math 출력값
            n = n())                       # 학생 수

# summarise()에 자주 사용하는 요약 통계량 함수
#   mean()    : 평균
#   sd()      : 표준편차(standard deviation)
#   sum()     : 합계
#   median()  : 중앙값
#   min()     : 최솟값
#   max()     : 최댓값
#   n()       : 빈도

# 4) 각 집단별로 다시 집단 나누기
mpg %>% 
  group_by(manufacturer, drv) %>%          # 회사별, 구동 방식별 분리
  summarise(mean_city = mean(cty)) %>%     # cty 평균 산출
  head(10)                                 # 일부 출력

#----------------------------------------------------------------------------------------------------------------------------------------------
## dplyr 조합하기
# 회사별로 "suv" 자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로 정렬하고, 1~5위까지 출력하기
library(ggplot2)
mpg = as.data.frame(ggplot2::mpg)

# mpg %>% 
#   group_by(manufacturer) %>%         # 회사별로 구분
#   filter(class == "suv") %>%         # suv 추출
#   mutate(total = cty + hwy,
#          avg = total / 2) %>%        # 연비 합계와 평균 정보 열 추가
#   arrange(desc(avg)) %>%             # 내림차순으로 정렬
#   head(5)                            # 1~5위까지 출력
  
mpg %>% 
  group_by(manufacturer) %>%          # 회사별로 구분
  filter(class == "suv") %>%          # suv 추출
  mutate(tot = (cty + hwy) / 2) %>%   # 연비 합계와 평균 정보 열 추가
  summarise(mean_tot = mean(tot)) %>% # 통합 연비 평균 산출
  arrange(desc(mean_tot)) %>%         # 내림차순으로 정렬
  head(5)                             # 1~5위까지 출력
  
#----------------------------------------------------------------------------------------------------------------------------------------------
# Question ] mpg 데이터를 이용해 분석 문제를 해결해 보세요.
# Q1. mpg 데이터의 class는 "suv", "compact" 등 자동차를 특징에 따라 일곱 종류로 분류한 변수입니다. 어떤 차종의 도시 연비가 더 높은지 비교해
#     보려고 합니다. class별 cty 평균을 구해 보세요.
mpg %>%
  group_by(class) %>%             # class로 분류
  summarise(mean_cty = mean(cty)) # class별 cty 평균 구하기

# Q2. 앞 문제의 출력 결과는 class 값 알파벳 순으로 정렬되어 있습니다. 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 cty 평균이 높은 순으로
#     정렬해 출력하세요.
mpg %>%
  group_by(class) %>%                       # class로 분류
  summarise(mean_cty = mean(cty)) %>%       # class별 cty 평균 구하기
  arrange(desc(mean_cty))                   # 평균이 높은 순으로 정렬해 출력

# Q3. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려고 합니다. hwy 평균이 가장 높은 회사 세 곳을 출력하세요.
mpg %>%
  group_by(manufacturer) %>%                # 회사로 분류
  summarise(mean_cty = mean(cty)) %>%       # 회사별 cty 평균 구하기
  arrange(desc(mean_cty)) %>%               # 평균이 높은 순으로 정렬해 출력
  head(3)                                   # 평균이 가장 높은 회사 세 곳 

# Q4. 어떤 회사에서 "compact"(경차) 차종을 가장 많이 생산하는지 알아보려고 합니다. 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.
mpg %>% 
  filter(class == "compact") %>%            # 경차 차종만 정렬
  group_by(manufacturer) %>%                # 회사별 정렬
  summarise(n = n()) %>%                    # 차종 수 표시
  arrange(desc(n))                          # 차가 많은 순서대로 정렬
