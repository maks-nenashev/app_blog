document.addEventListener('DOMContentLoaded', () => {
  const modalEl = document.getElementById('findWayMobileVideoModal');
  if (modalEl) {
    modalEl.addEventListener('hidden.bs.modal', () => {
      const video = modalEl.querySelector('video');
      if (video) video.pause();
    });
  }
});