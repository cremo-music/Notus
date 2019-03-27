FROM swift:latest

COPY . /notus
WORKDIR /notus

RUN swift build

CMD swift test