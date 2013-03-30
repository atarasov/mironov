
$('#myTab a:first').tab('show');

$('#myTab a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
})

$('a[class="tab-pane"]').on('show', function (e) {
    e.target // activated tab
    e.relatedTarget // previous tab
})