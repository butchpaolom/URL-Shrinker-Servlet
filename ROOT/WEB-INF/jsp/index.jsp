<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>URL Shrinker</title>
    <link rel="stylesheet" href="/static/css/animate.min.css" />
    <link rel="stylesheet" href="/static/css/bootstrap/bootstrap.css" />
  </head>

  <body>
    <div class="d-flex justify-content-center p-1">
      <div class="container m-4">
        <div class="card">
          <!-- <img
          class="card-img-top"
          src="/images/pathToYourImage.png"
          alt="Card image cap"
        /> -->
          <div class="card-body">
            <h4 class="card-title">URL Shrinker! Try me!!</h4>
            <div class="input-group mt-4" id="shrinker-div">
              <input type="text" class="form-control border-danger" id="url" />
              <div class="input-group-append">
                <button class="btn btn-success" id="shrink_button">
                  Shrink
                </button>
              </div>
            </div>
            <div class="mt-4">
              <div class="col-4 p-0">
                <div class="input-group">
                  <input type="text" class="form-control" id="new-url" />
                  <div class="input-group-append">
                    <button class="btn btn-success" id="copy_button">
                      Copy
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
  <script>
    document.getElementById("url").addEventListener("keyup", () => {
      let url = document.getElementById("url");
      if (url.value.length != 0) {
        url.classList.remove("border-danger");
      } else {
        url.classList.add("border-danger");
      }
    });
    document
      .getElementById("shrink_button")
      .addEventListener("click", async () => {
        let response = await fetch("/api", {
          method: "POST",
          body: JSON.stringify({ url: document.getElementById("url").value }),
        });
        if (response.ok) {
          let result = await response.json();
          document
            .getElementById("shrink_button")
            .setAttribute("disabled", true);
          let newUrl = document.getElementById("new-url");
          newUrl.value = result.url;
        } else {
          let shrinkerDiv = document.getElementById("shrinker-div").classList;
          shrinkerDiv.toggle("animate__animated");
          shrinkerDiv.toggle("animate__bounce");
        }
      });
    document.getElementById("copy_button").addEventListener("click", () => {
      let newURL = document.getElementById("new-url");
      newURL.select();
      document.execCommand("copy");
    });
  </script>
</html>
