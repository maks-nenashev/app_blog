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

// Обработчик для миниатюр изображений
// Обновление главного изображения при клике на миниатюру
document.addEventListener("turbo:load", function() {
  var allThumbs = document.querySelectorAll('.preview-image');
  allThumbs.forEach(function(thumb) {
    thumb.addEventListener('click', function() {
      var mainImg = document.getElementById('main-image');
      if (mainImg) mainImg.src = this.dataset.large;
      // выделить выбранную миниатюру рамкой
      allThumbs.forEach(t => t.classList.remove('border-primary'));
      this.classList.add('border-primary');
    });
  });
});