$(function() {

// インクリメンタルサーチのメソッド
  function buildHtmluser(user){
    var user_nickname = user.nickname;
    var user_id = user.id;
    var html =  '<li class = "chat-group-form__result">' +
                      user_nickname +
                      '<a id ="add_button" type = "button" data-user-name="' + user_nickname + '"data-user-id=' + user_id +'>' + '追加' +
                      '</a>' +
                      '</li>';
    $('#user-search-result').append(html);
  }

// 追加したユーザーを表示するメソッド
  function addHtmluser(name, id){
    var html =   '<p class = "chat-group-add-user__name">' +
                       name +
                      '<input name = "chat_group[user_ids][]" type = "hidden", value =' + id + ' >' +
                      '<a class = "chat-group-form__delete-btn" data-user-id ='+ id +'>' + '削除' +
                      '</a>' +
                      '</p>';
    $('.chat-group-user').append(html);
  }

  function ajaxSearch(input) {
    if (input.length !== 0) {
      $.ajax({
        type: 'GET',//routsにてhttpメソッドがGET、且つ、
        url: "/users",//routesにて/usersのURLのパスが読み込まれる。
        data:
          {
            user_name: {
            keyword: input
              }
          },
        dataType: 'json'
        })
        .done(function(json) {
         // jsonの中身は配列として帰ってくる
          $.each(json, function(i, user){
            buildHtmluser(user);
          });
        })
        .fail(function() {
          alert('メッセージを入力してください。');
        });
    }
    else{
    $(".chat-group-form__result").remove();
    }
  };

  $('#user-search-field').on('keyup', function() {
    input = $.trim($(this).val());
      $(".chat-group-form__result").remove();
      ajaxSearch(input);
  });

  $(document).on('click', '#add_button', function() {
    var user_name = $(this).data('user-name');
    var user_id = $(this).data('user-id');
    addHtmluser(user_name, user_id);
    $(this).parent().remove();
  });

  $(document).on('click', '.chat-group-form__delete-btn', function() {
    $(this).parent().remove();
  });
});
