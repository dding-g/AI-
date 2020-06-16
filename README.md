**Artificial Intelligence**

**Final Report Template**

**Due date: 2020/6/22**

\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

**이름: 조명근**

**학번: 20155165**

**주제 : normal, murmur, extrasystole 심음들의 classification**



1.  **서론**
    1.  본 보고서는 심음에 대한 학습 및 예측과 데이터 분석에 대한 결과이다.

    2.  학교에서 배우는 수업들에서 sound data에 대한 분석을 한번도 배운 적이 없다. 그림 data 및 정적인 데이터들에 대해서 분석을 해본적은 있지만 연속적인 data에 대해서는 처음이다. 다양한 데이터들을 활용해 AI를 접해보고자 Sound Data를 이용해 데이터를 학습시키고, 분석해보겠다.

2.  **문제**

    1.  심박은 PQRS 파형으로 이루어져 있다. 영화에서 보는 것처럼 모니터에 심장이 뛰는 그래프가 그려지는게 PQRS파형이다. 이는 ECG(심전도) 측정을 통해서 알 수 있고 대부분의 심장병 들을 판단하는 근거가 된다. 하지만 측정하려면 측정 센서 및 기구가 필요하며 병원을 찾아가야 한다. 하지만 심음은 심전도에 비해 측정이 간편하고 심잡음(murmur) 데이터를 통해 알 수 있는 질병도 있다.(1) 따라서 비교적 간단하게 측정 할 수 있는 심음 데이터를 정상과 비정상 데이터로 기계학습을 통해 나눠 보자는 생각에서 출발하였다.

    2.  기존 심음이 “두근 두근 (lub-dub)” 한 소리가 난다고 하면 심잡음(murmur)은 “두근 쉬익 두근(lub-shi-dub)” 소리가 난다.(3) 심방에서 심실로 피가 통할 때 열리는 “이첨판” 이나 “삼천판”의 판막이 제대로 닫히지 않아 피가 역류하면서 나오는 현상이다. 이런 질병을 “심장판막증” 이라고 한다.

    3.  본 보고서는 정상(normal), 심잡음(murmur), 심실 조기 수축(extrasystole)의 sound data를 토대로 정상 심음과 비정상 심음(murmur, extrasystole)을 분류하기 위해 작성하였다.

3.  **Dataset 정의**

    1.  Dataset(2) 은 정상 심음(normal), 심 잡음(murmur), 심실 조기 수축(extrasystole) 총 3가지로 구성되어 있다. Dataset은 set a와 set b로 나뉘는데 set a는 iphone으로 일반인이 측정한데이터 이고 set b는병원에서 디지털 청진기로 측정한 데이터이다.

    2.  본 보고서는 set a와 set b의 정상 심음, 심 잡음, 심실 조기 수축 의 데이터를 토대로 진행되었다. 심음이 다른 방해되는 noise(차소리, 말소리 등)들을 포함하지 않고 있다는 가정하에 진행하였다. 실제로 Dataset의 set b폴더는 병원의 디지털 청진기로 측정한 데이터로 호흡 소리를 제외한 잡음은 거의 찾아보기 힘들다. Set a에 있는 파일들도 바람 소리 같은 잡음은 포함되어 있으나 너무 씨끄러운 환경에서 녹음된 파일은 아닌걸로 확인하였다. 심장음은 정상 심음 set a : 31개, set b : 200개, 심잡음(murmur) 데이터 set a : 34개, set b : 66개와 심실조기수축(extrasystole) 데이터 set a : 19개, set b : 46개를 사용하였다.

    3.  **Dataset 전처리**

        1.  오디오 파일마다 길이가 다르기 때문에 파일 길이를 일반화 시켜 주어야 한다. 파일의 평균 길이는 5 ~ 6초 이지만 평균 값을 기준으로 파일을 가르게 되면 dataset이 너무 적어져 오디오 파일 길이를 3초 기준으로 3초보다 적게 녹음된 파일들은 dataset 구성에서 제외시켰다. 파일 길이는 ![image](https://user-images.githubusercontent.com/29707967/84743051-587dbf00-afec-11ea-8d7b-3a38c340da85.png) 로 계산하였다. 따라서 bitrate 4000기준으로 3초 파일의 data length 는 12000이다.

            1.  Audio data는 연속적 데이터들의 집합이기 때문에 image 처럼 data을 펼쳐 주지 않아도 된다.

        2.  Set a 의 경우 bitrate가 44100이다. 1초에 들어있는 audio data가 bitrate 4000에 비해 11배이상 많기 때문에 데이터를 압축하는 작업이 필요 하다.

            1.  줄이는 방식은 1 ~ 10까지 인덱스가 있을때 이 값 중 가장 큰 값을 저장하는 방식이다. 44100 bitrate에서 10의 size를 가지는 audio data는 ![image](https://user-images.githubusercontent.com/29707967/84743084-66cbdb00-afec-11ea-821b-d066fe1a2aa2.png)라는 굉장히 작은 데이터 이기 때문에 급격하게 audio data가 변하지는 않으므로, 범위 내의 가장 큰 값을 뽑아와 저장하는 방식이 가장 알맞다고 생각했다. 이 방법은 CNN의 polling 에서 착안하였다.

        3.  모든 데이터가 3초 이상(12,000) 측정된 것은 아니다. 따라서 모든 데이터 셋을 12,000 으로 정규화 시키려면 3초 미만으로 측정된 데이터들을 수정해야한다. size가 12,000에 미치지 않는 데이터는![image](https://user-images.githubusercontent.com/29707967/84743147-7cd99b80-afec-11ea-9265-a834cf42b90a.png) 까지 0으로 채워 학습에 지장이 없도록 하였다.
        4.  Normal Dataset의 shape은 12,000 x 231 으로 이루어진다.
        5.  Murmur Dataset의 shape은 12,000 x 100 으로 이루어진다.
        6.  Extrasystole Dataset의 shape은 12,000 x 65 으로 이루어진다.

    4.  input / output 정의

        1.  Input 데이터는 train과 test 로 나뉜다.

            1.  Normal Dataset의 Train, Test 데이터를 각각 184, 47개로 나눈다.

            2.  Murmur Dataset은 Train, Test 데이터를 각각 80, 20개로 나눈다.

            3.  Extrasystole Dataset은 Train, Test 데이터를 각각 52, 13개로 나눈다.

            4.  따라서 세가지 train data를 합한 trainX는 316 x 12,000 이고 testX는 80 x 12,000 이다.

            5.  수학적 표기

                1.   ![image](https://user-images.githubusercontent.com/29707967/84743188-8cf17b00-afec-11ea-8c71-1e9d2642512f.png)이와 같이 표현한다. 여기서 은 위에서 정의한 Normal, Murmur, Extrasystole 의 train data 이고 은 위에서 정의한 test data 이다. 에서 는 데이터가 몇번째 데이터인지를 정해주는 index이다.
                2.   ![image](https://user-images.githubusercontent.com/29707967/84743207-92e75c00-afec-11ea-9580-36064954b1c3.png)
                3.   ![image](https://user-images.githubusercontent.com/29707967/84743209-94188900-afec-11ea-996a-2e2b7a06f5ef.png)

        2.  Output 데이터는 train과 test로 나뉜다.

            1.  Normal, Murmur, Extrasystole로 총 3가지로 구성되어 있다.

            2.  ![image](https://user-images.githubusercontent.com/29707967/84743223-9a0e6a00-afec-11ea-86d3-655aaeb36482.png)으로 정의한다.

            3.  input/output의 columns size는 같아야 한다. Data 하나 하나 label을 붙여야 하기 때문이다. 따라서 output data의 trainY, testY의 size는 316x1, 80x1 이다.

            4.  수학적 표기

                1.  ![image](https://user-images.githubusercontent.com/29707967/84743239-a09ce180-afec-11ea-86c9-c6069186c734.png)
                2.  ![image](https://user-images.githubusercontent.com/29707967/84743245-a266a500-afec-11ea-9807-a11495c3b85d.png)

        3.  Bias 추가

            1.  Bias를 추가해야 하므로 ![image](https://user-images.githubusercontent.com/29707967/84743263-a85c8600-afec-11ea-98f9-c7cb4a6e6f7c.png)이와 같은 형태로 trainX의 최상위 column에 one-vector를 추가한다.

    5.  Dataset 크기

        1.   ![image](https://user-images.githubusercontent.com/29707967/84743293-b3afb180-afec-11ea-8bee-6e2b07e13240.png)는 316 x 12,000이고, 는 80 x 12,000이다.
        2.   ![image](https://user-images.githubusercontent.com/29707967/84743301-b6120b80-afec-11ea-971a-27cceddbe139.png)는 316 x 1 이고, 는 80 X 1 이다.

4.  **문제 풀이**

    1.  구하고자 하는 것

        1.  기계학습은 결과(output)를 예측할때 사용되는 최적의 해(weight)를 구해야한다. 따라서 우리는 궁극적으로 해당 모델에 사용되는 최적의 를 찾아야한다.

    2.  Optimize

        1.  SGD(Stochastic gradient descent)는 random 하게 추출된 데이터들을 사용해 최적의 weight를 찾게 된다. SGD의 장점은 모든 batch를 사용하는게 아닌 원본보다 적은 데이터. 즉 mini batch 를 사용함으로써, BGD(Batch Gradient Descent) 보다 훨씬 빠르다는 장점이 있으나 정확도는 BGD보다 낮을 수 있다. 여기서 Training set이 12,000 X 316 이므로 적지 않은 데이터 크기를 가지고 있으며 GD보다는 SGD를 활용하는게 낫다고 판단했다. 실제로 SGD는 모델만 잘 설정되어 있다면 GD와 큰 차이를 보이지 않는다.

    3.  Loss function

        1.  Multinomial Logistic Regression 을 사용한다. 3가지 class를 구분해야 하기 때문에 Binary Classification을 구하는 방식으로는 할 수 없다.

            1.  MLR을 이해하기 위해선 먼저 Binary Classification의 경우를 이해해야한다. “1” 과 “0”, 두가지 Class를 구분하기 위한 model이 ![image](https://user-images.githubusercontent.com/29707967/84743360-c75b1800-afec-11ea-8d74-18a79b1916f4.png) 일때 행렬 연산을 살펴보면 ![image-20200616161706117](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616161706117.png) 이 된다. 이걸 일반화 하면 ![image-20200616161710712](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616161710712.png) 이다. 그리고 예측 결과 확률인 ![image-20200616161718248](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616161718248.png) 을 구하기 위해서![image-20200616161730252](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616161730252.png) 을 사용하여 결과로 나온 일반 상수를 0이상 1이하의 확률값으로 바꾸어 준다. 이 때 Binary Classification은 하나의 확률을 구하면 다른 확률은 1에서 빼면 되는 ![image-20200616161737321](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616161737321.png)의 관계가 성립한다. 하지만 class의 갯수가 3개 이상이 되면 위의 관계는 성립하지 않는다. 따라서 우리는 MLR에서 사용되는 Softmax를 사용해야한다. 
            2.  Softmax는 ![image-20200616161747684](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616161747684.png)이며, 로 구한 모든 값을 sum 한 후, 에 대해 나누어 0이상 1이하의 확률값을 구한다.

5.  1.  Training 과정

        1.  Training Set을 불러온다.
        2.  다음은 SGD를 이용해 데이터를 학습시켰다. 아래 그림과 같이 train loss 가 줄어드는 속도에 비해 test loss는 크게 줄어들지 않고, test accuracy 도 거의 변하지 않는걸 볼 수 있다.

            1.  ![image](https://user-images.githubusercontent.com/29707967/84743485-fffaf180-afec-11ea-8cf9-55a099fae890.png)

                1.  Train : 파란색, Test : 주황색 그래프이다. 이하 그래프에서는 설명은 생략한다.
                2.  어느 부분에서 accuracy가 변하지 않는지를 보기위해 iter는 500회로 크게 주었으며 Learning rate(alpha)은 ![image-20200616161837884](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616161837884.png)로 주었다.
                3.  이 방법에서는 iter 100회에서 가장 큰 accuracy를 보였다.
                4.  Loss 값은 test loss는 1 이상을 유지하는 만큼 좋지 않은 성과를 보여주었다.

        3.  위 방법보다 accuracy를 높이기 위해 learning rate를 더 작게 주었다(). 이렇게 하면 gradient(theta)를 더 촘촘하게 탐색(다음 gradient를 탐색하는 거리가 좁아진다는 뜻) 하게 되므로 gradient를 잘 찾아 정확도를 올릴 수 있을것이라 생각했다.

            1.  ![image](https://user-images.githubusercontent.com/29707967/84743522-0e490d80-afed-11ea-8f90-962bf1436bc7.png)

                1.  Learning rate을 작게 준 만큼 탐색 속도가 느려지므로, epoch를 1,000회로 수정하였다.
                2.  첫번째 시도에서 보였던 방법에서 epoch 80회 정도에서의 성능을 보여주었다.
                3.  Learning rate을 더이상 작게 주는건 무의미하다고 판단했다.

        4.  Learning rate을 ![image](https://user-images.githubusercontent.com/29707967/84743544-143eee80-afed-11ea-9b29-2adb43eee161.png)으로 조금 높여보았다.

            1.  ![image](https://user-images.githubusercontent.com/29707967/84743563-1a34cf80-afed-11ea-811c-4bb8c446dcbb.png)

            2.  너무 큰 값이라 그런지 loss도 더이상 떨어지지 않고 gradient를 잘 찾지 못해서 생기는 일이라고 생각했다.

        5.  Learning rate을 1e-4 로 주었을 경우.

            1.  ![image-20200616161916391](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616161916391.png)

            2.  위와 별 다른 차이는 없었다.

        6.  Learning rate은 1e - 5 가 가장 최적의 값이라고 판단하였고 epoch을 110 으로 주었을때 가장 결과가 잘 나왔으므로 random하게 생성되는 theta에 의해 accuracy가 조금씩 차이가 날 수 있다.

            1.  ![image](https://user-images.githubusercontent.com/29707967/84743601-24ef6480-afed-11ea-8c87-c8b8d2be84df.png)

6.  **Octave 구현 방법**
    1.  모든 Octave 코드는 [*https://github.com/dding-g/AI-FinalProject*](https://github.com/dding-g/AI-FinalProject) 에 공개하였다.
    2.  Dataset 구성 및 전처리
        1.  ![image](https://user-images.githubusercontent.com/29707967/84743649-346ead80-afed-11ea-85ca-2615b8093926.png)
            1.  Data 전처리 코드
            2.  Normal, murmur, extrasystole 은 모두 같은 방식으로 구현하였기 때문에 설명을 위해 normal 코드만 보도록 하겠다.
            3.  먼저 dataset의 초기 크기를 zeros() 로 설정해주고 audio file을 읽어온다.
            4.  Set a

                1.  Bitrate 가 44100 이므로 bitrate을 4000 까지 떨구어야 한다. 따라서 해당 작업을 해줄 transformBitrate function을 새로 만들었다.
                    1.  ![image-20200616162049395](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616162049395.png)
                        1.  Audio data를 압축하는 코드
                        2.  여기서는 10의 크기만큼(44100 bitrate 이기 때문에 1초에 44100의 데이터가 저장된다. 이때 10의 크기는 매우 작은 숫자이다)의 데이터에서 max 값을 뽑아 저장한다.

            5.  Set b

                1.  모든 bitrate가 4000이므로 전처리를 해줄 필요가 없다.

            6.  읽어온 data가 12,000 이상의 크기를 가지고 있으면 12,000까지 잘라서 읽어 저장하고, 12,000 이하의 크기이면 error가 발생하므로 try-catch 문에서 예외처리를 해준다. 12,000 이하의 크기를 가진 data에는 12,000까지 0 을 넣어준다.
    3.  Dataload

        1.  ![image-20200616162221642](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616162221642.png)

            1.  Data들을 차례대로 불러와 Xtrain, Xtest 에 저장한다.

            2.  1, 2, 3의 class를 갖는 데이터들을 저장한다.
    4.  Training and Test

        1.  ![image-20200616162226610](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616162226610.png)

            1.  Train, test의 크기가 다르기 때문에 변수에 저장하고 bias를 추가할때 맞는 size를 준다.

        2.  ![image-20200616162231997](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616162231997.png)

            1.  매번 학습된 값이 바뀌는데 이는 처음 theta값을 random으로 설정하기 때문이다.

            2.  여러 시도를 통해 위의 값이 가장 적합한 Learning rate 이라고 판단했다. Learning rate가 너무 크면 다음 gradient를 탐색할때 local minima(더 작은 gradient가 있음에도 불구하고 현재 최소라고 생각되는 굴곡에 빠져 다음 최소점을 찾지 못하는 현상) 에 빠질 수 있으므로 조심해야한다.

            3.  Overfitting 을 막기 위해 lambda(regularization cost) 값을 적당하게 준다. 여러가지 시도를 통해 해당 값에서 가장 loss가 낮다고 판단했다. Lambda가 커질수록 data들은 원점(zero)에 가까워 지며(멀어지면 regression을 할때 조금만 gradient가 바뀌어도 결과가 급격하게 바뀐다.) class들을 표현하기 더 용이해 진다.

        3.  ![image-20200616162236167](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616162236167.png)

            1.  Multinomial Logistic Regression 함수이다.

            2.  MLR의 수식대로 Xtrain\*th 값을 softmax 시켜 확률값으로 만든 후 th에 값을 class별로 갱신한다.

            3.  Xtrain과 th를 내적한 linear\_h 를 생성한다. 이는 내가 예측할때 쓰이는 value이다. 이 linear\_h는 size(Xtrain) x 3 의 형태이다.

            4.  위 linear\_h 에 softmax function을 씌워 확률을 구하고 이는 training loss 값에 영향을 주는 hp(hyper parameter)에 저장한다. 그리고 값을 상대적으로 줄이기 위해 log를 씌우고 현재 train\_loss 값에서 지금 구한 hp를 뺀다.

            5.  마지막으로 hp의 3가지 class 중 가장 높은 확률을 가진 값을 꺼내 ypred에 저장한다. 이제 class가 저장된 Ytrain과 예측한 값인 ypred가 같은지 비교하여 정확도를 계산한 것이 train\_accuracy에 저장된다.

        4.  ![image-20200616162241454](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616162241454.png)

            1.  Test accuracy를 구할때도 train accuracy를 구할때와 방법은 동일하다.

            2.  Hyper parameter를 구하고 해당 row의 가장 높은 확률을 보이는 class를 ypred에 저장한다.

            3.  Ytest에 저장된 class와 ypred에 저장된 class가 같은지 아닌지를 구해 accuracy를 구한다.

7.  **결론**

    1.  Learning rate 1e - 5와 epoch를 120정도로 주었을때 가장 accuracy가 높았다. 이는 th 값이 매번 random 하게 바뀌기 때문에 결과의 loss값은 정도의 차이가 났다. 같은 option으로 15번 학습을 했을 때, 최대로 잘 나온 test accuracy는 0.62 이고 최대로 낮게 나온 accuracy는 0.519 였다.

    2.  위에서 사용한 MLR\_SGD 모델은 이미 검증된 모델이다. MNIST를 사용한 숫자 그림을 잘 구분해 내는 걸 보았다. 하지만 여기서 sound data는 잘 구분해 내지 못했다.

    3.  Accuracy가 생각보다 낮게 나왔다. Sound data에 바람소리 같은 잡음들이 많이 들어가 있어서 양질의 theta 값들이 나오지 않은점. Data를 전처리 할 때 12,000 size 가 안된(3초 보다 측정시간이 적은) 파일들에 강제로 data를 0을 삽입한 점 을 미루어 보았을 때 데이터의 전처리 방식이 잘못 된 것 같다. 혹은 sound data는 ![image-20200616162305949](C:\Users\jmg\AppData\Roaming\Typora\typora-user-images\image-20200616162305949.png)의 범위를 가지기 때문에 위에서 사용한 모델이 minus값에 적용되지 않을지도 모르겠다. 또한 murmur, extrasystole 도 똑같이 심음이 녹음되지만, 녹음 되는 중간에 특정한 다른 sound 들이 들리게 된다. 이 sound들은 audio graph에서도 뚜렷이 나타날 만큼 날카로운 값이지만 audio file을 read해서 얻은 sound 센서에서 측정된 값들만 가지고 특징을 추출하기는 어려웠던것 같다. MFCC 방식을 통해 sound data를 시각적으로 바꾸고 시각적으로 바꾼 사진에서 특징들을 추출해 내어 classification 하는 방식이 더 효과적이라고 생각한다.

    4.  위의 방식으로 Normal, Murmur, Extrasystole 을 Classification 하는 건 좋지않은 결과를 내었다. 위에서 말한 것 처럼 MFCC 방식을 통해 이미지에서 특징을 추출해 내어 classification 하는 방식이 더 효과적일 것이라고 생각한다.

8.  **참고자료**

    1.  [*https://disedata.wordpress.com/s1r30/*](https://disedata.wordpress.com/s1r30/)

    2.  [*https://www.kaggle.com/kinguistics/heartbeat-sounds/*](https://www.kaggle.com/kinguistics/heartbeat-sounds/)

    3.  [*https://youtu.be/dBwr2GZCmQM?t=98*](https://youtu.be/dBwr2GZCmQM?t=98)