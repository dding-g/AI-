## Normal한 심장음과 Not Normal 한 심장음의 Classification


### 1.	Dataset 정의
  1. Dataset(1) 은 정상 심음(normal), 심 잡음(murmur), 심실 조기 수축(extrastole) 총 3가지로 구성되어 있다. Dataset은 set_a와 set_b로 나뉘는데 set_a 는 iphone으로 일반인이 측정한데이터 이고 set_b는 병원에서 디지털 청진기로 측정한 데이터이다.
  2. 본 보고서는 정상 심음(set_a, set_b), 심 잡음(set_b), 심실 조기 수축(set_b) 의 데이터를 토대로 진행되었다. 심음이 다른 방해되는 noise(차소리, 말소리 등)들을 포함하지 않고 있다는 가정하에 진행하였다. 실제로 Dataset의 set_b폴더는 병원의 디지털 청진기로 측정한 데이터로 호흡 소리를 제외한 잡음은 거의 찾아보기 힘들다. 심장음은 정상 심음 243개, 심잡음(murmur) 데이터 66개와 심실조기수축(extrastole) 데이터 46개를 사용하였다.

### 2.	Dataset 전처리
  1. 오디오 파일마다 길이가 다르기 때문에 파일 길이를 일반화 시켜 주어야 한다.  파일 길이는 5초로 잘라주었으며 길이가 5초 미만인 데이터는 dataset 구성에서 제외시켰다.
  2. Nomal(정상 심음) 데이터는 5000x223 형태로 이루어진다.
  3. Murmur(심잡음) 데이터는 5000x68 형태로 이루어진다.
  4. Extrastole(심실 조기 수축) 데이터는 5000x48 형태로 이루어진다.



### 참 고 자 료

  1. https://www.kaggle.com/kinguistics/heartbeat-sounds 

