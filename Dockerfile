FROM python:3.9.14-slim-bullseye
LABEL maurizweymann <s0528279@htw-berlin.de>

# Update system packages
RUN apt update -y && \
    apt upgrade -y && \
    apt dist-upgrade -y

# Install time package
RUN apt install -y \
        tzdata \
        iputils-ping

# Cleanup
RUN apt clean && \
    apt autoremove && \
    rm -rf /var/cache/apk/*

# Install python components
RUN pip3 install --no-cache-dir numpy \ 
                               pandas \
                               scikit-learn \
                               minio

# Create app dir
RUN mkdir game

# Copy data to image
COPY hangman.py /game

# Start hangman
CMD python3 /game/hangman.py
#CMD tail -f /dev/null