#!/bin/python3

from flask import Flask, request
from werkzeug import secure_filename
app = Flask(__name__)

FORM = """
<html>
<form action="/" enctype="multipart/form-data" method="post">
<input type="file" name="the_file" multiple="multiple" />
<input type="submit" name="submit" />
</form>
</html>
"""

@app.route("/", methods=["GET", "POST"])
def form():
    if request.method == "POST":
        for f in request.files.getlist('the_file'):
            f.save('./' + secure_filename(f.filename))
    return FORM


if __name__ == "__main__":
    app.run(host='0.0.0.0')
