FROM tindy2013/subconverter:latest
# assume your files are inside replacements/
RUN rm /base/pref.*
COPY ./pref.example.toml /base/
# expose internal port
EXPOSE 25500

CMD ["subconverter"]