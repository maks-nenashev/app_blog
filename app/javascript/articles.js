document.addEventListener("turbo:load", function () {
  // Получение модального окна
  var modal = document.getElementById("myModal");

  // Получение изображения и вставка его в модальное окно
  var img = document.getElementById("myImg");
  var modalImg = document.getElementById("img01");
  var captionText = document.getElementById("caption");

  if (img && modal && modalImg && captionText) {
    img.onclick = function () {
      modal.style.display = "block";
      modalImg.src = this.src;
      captionText.innerHTML = this.alt;
    };
  }

  // Получение элемента <span>, который закрывает модальное окно
  var span = document.getElementsByClassName("close")[0];

  if (span && modal) {
    span.onclick = function () {
      modal.style.display = "none";
    };
  }
});