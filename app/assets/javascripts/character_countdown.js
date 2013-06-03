function updateCountdown() {
    var characters_left = 140 - jQuery('#micropost_content').val().length;
    var result = "";
    
    if( characters_left == 1)
      result = characters_left + " character remaining.";
    else if (characters_left == -1)
      result = characters_left + " additional character.";
    else if (characters_left < -1)
      result = characters_left + " additional characters.";
    else
      result = characters_left + " characters remaining.";

    jQuery('.countdown').text(result);
}

jQuery(document).ready(function($) {
    updateCountdown();
    $('#micropost_content').change(updateCountdown);
    $('#micropost_content').keyup(updateCountdown);
});