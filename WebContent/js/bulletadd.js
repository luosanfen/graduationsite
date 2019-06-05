layui.config({
	base : "js/"
}).use([ 'form', 'layer', 'jquery', 'layedit', 'laydate' ], function() {
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		laypage = layui.laypage,
		layedit = layui.layedit,
		laydate = layui.laydate
})

function save_cat(){
	if($("#categoryName").val() == ""){
		return;
	}
	if($("#parentCatID").val() == ""){
		return;
	}
	$.ajax({
		url : "../admin",
		data : $("#catFrom").serialize(),
		type : "post",
		dataType : "json",
		success : function(data) {
			window.top.layer.msg(data.msg);
			if (data.state == 1) {
				parent.window.close();
				//刷新父页面
				parent.window.location.reload();
			}
		}
	});
}