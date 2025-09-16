FROM amazoncorretto:8-alpine

RUN apk update && \
  apk add py3-pip \
  git \
  expat \
  libxml2-utils \
  icu-dev \
  curl \
  jq \
  --no-cache bash \
  zip


ENV LANG=en_US.UTF-8

RUN apk add --no-cache py3-pip py3-requests py3-lxml

RUN mkdir -p /collatex/collatex-tools/target/
WORKDIR /collatex/collatex-tools/target/

RUN curl https://oss.sonatype.org/service/local/repositories/releases/content/eu/interedition/collatex-tools/1.7.1/collatex-tools-1.7.1.jar -o collatex-tools-1.7.1.jar

WORKDIR /


RUN git clone https://github.com/seretan/tpen2tei

RUN cd tpen2tei && git checkout xmlrich_tokenization

WORKDIR /home/

COPY shell-scripts/xml2stemmarest.sh.zip /bin/xml2stemmarest.sh.zip
RUN unzip /bin/xml2stemmarest.sh.zip -d /bin

COPY utils/relations.txt .
COPY utils/abbr.csv .

# If you want to run the script outside of docker-compose and to copy your own MSS files,
# you also need to use the argument --build-arg MSS_PATH=your_path when building the docker image
ARG MSS_PATH=corpus
COPY $MSS_PATH ./data

# the container is ran in interactive mode to keep it alive and let examine the output files
# you can also run it in detached mode or stop the container after the script ends

CMD /bin/xml2stemmarest.sh /home/data /home/out/ -m && tail -f /dev/null