var http = require("http");
var fs = require("fs");
var qs = require("querystring");

var server = http.createServer(handleRequest).listen(8000);

function handleRequest(req, res) {
  if (req.method === "GET") {
    res.writeHead(200, { "Content-Type": "text/html" });
    var readStream = fs.createReadStream("index.html", "UTF-8");
    readStream.on("open", function() {
      readStream.pipe(res);
    });
    readStream.on("error", function(err) {
      res.end(err);
    });
  } else if (req.method === "POST") {
    var body = "";
    req.on("data", function(chunk) {
      body += chunk;
      var post = qs.parse(body);
      console.log(
        "Name: " +
          post.name +
          "\nEmail: " +
          post.email +
          "\nPassword: " +
          post.password +
          "\nFilename: " +
          post.myFile +
          "\nCategory: " +
          post.category +
          "\n"
      );
      var returnString =
        "Name: " +
        post.name +
        "\nEmail: " +
        post.email +
        "\nPassword: " +
        post.password +
        "\nFilename: " +
        post.myFile +
        "\nCategory: " +
        post.category +
        "\n";
    });

    req.on("end", function() {
      res.writeHead(200, { "Content-Type": "text/html" });
      res.end(body);
    });
  }
}
console.log("Listening at port 8000");
