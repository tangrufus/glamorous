$(function () {
  if (! $('[data-at-mention="autocomplete"]'))
    return;

  $('[data-at-mention="autocomplete"]').atwho({
    at: "@",
       data: "/users.json",
       displayTpl: '<li>${username} <small>${email}</small></li>',
       insertTpl: '@${username}',
       delay: 400,
       limit: 30
  });
});
