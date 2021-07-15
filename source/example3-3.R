library(ggplot2)
# 여러 문자로 구성된 변수 생성
x <- c("a", "b", "c", "d")
x

# 빈도 막대 그대로 출력
qplot(x)

# data에 mpg, x축에 hwy 변수 지정해 그래프 생성
# hwy : 자동차가 고속도로에서 1갤런에 몇 마일을 가는지 나타낸 변수
qplot(data = mpg, x = hwy)

# x축 cty
qplot(data = mpg, x = cty)

# x축 drv, y축 hwy
qplot(data = mpg, x = drv, y = hwy)

# x축 drv, y축 hwy, 선 그래프 형태
qplot(data = mpg, x = drv, y = hwy, geom = "line")

# x축 drv, y축 hwy, 상자 그림 형태
qplot(data = mpg, x = drv, y = hwy, geom="boxplot")

# x축 drv, y축 hwy, 상자 그림 형태, drv별 색 표현
qplot(data = mpg, x = drv, y = hwy, geom="boxplot", color = drv)

# qplot 메뉴얼 확인
?qplot

# ------------------------------------------------------------------------------------

# Q1. 시험점수 변수 만들고 출력하기
# 다섯 명의 학생이 시험을 봤습니다. 학생들의 시험 점수를 담고 있는 변수를 만들어 출력해 보세요. 각 학생의 시험 점수는 아래와 같습니다.
# 80, 60, 70, 50, 90

# 학생들 이름 선언

stu_names <- c("A", "B", "C", "D", "E")
stu_scores <- c(80, 60, 70, 50, 90)

stu_scores

mean(stu_scores)

total_mean <- mean(stu_scores)
total_mean
