<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>


















































<!-- 首页 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>首页</title>
    <link rel="stylesheet" href="../../layui/css/layui.css">
    <!-- 样式 -->
    <link rel="stylesheet" href="../../css/style.css"/>
    <!-- 主题（主要颜色设置） -->
    <link rel="stylesheet" href="../../css/theme.css"/>
    <!-- 通用的css -->
    <link rel="stylesheet" href="../../css/common.css"/>
</head>
<body>

<div id="app">
    <div class="data-detail">
        <div class="data-detail-breadcrumb">
					<span class="layui-breadcrumb">
						<a href="../home/home.jsp">首页</a>
						<a><cite>{{detail.chushouName}}</cite></a>
					</span>


        </div>
        <div class="layui-row">
            <div class="layui-col-md5">
                <div class="layui-carousel" id="swiper">
                    <div carousel-item id="swiper-item">
                        <div v-for="(item,index) in swiperList" v-bind:key="index">
                            <img class="swiper-item" :src="item.img">
                        </div>
                    </div>
                </div>

            </div>
            <div class="layui-col-md7" style="padding-left: 20px;">
                <h1 class="title">{{detail.chushouName}}</h1>

                <div v-if="detail.huixingTypes" class="detail-item">
                    <span>户型：</span>
                    <span class="desc">
                        {{detail.huixingValue}}
                    </span>
                </div>

                <div v-if="detail.chushouMianji" class="detail-item">
                    <span>面积：</span>
                    <span class="desc">
                                {{detail.chushouMianji}}
                            </span>
                </div>

                <div v-if="detail.chushouMoney" class="detail-item">
                    <span>价格：</span>
                    <span class="desc">
                                {{detail.chushouMoney}}
                            </span>
                </div>

                <div v-if="detail.chushouSumMoney" class="detail-item">
                    <span>总价：</span>
                    <span class="desc">
                                {{detail.chushouSumMoney}}
                            </span>
                </div>

                <div v-if="detail.chushouWeizhi" class="detail-item">
                    <span>位置：</span>
                    <span class="desc">
                                {{detail.chushouWeizhi}}
                            </span>
                </div>

                <div v-if="detail.insertTime" class="detail-item">
                    <span>录入时间：</span>
                    <span class="desc">
                                {{detail.insertTime}}
                            </span>
                </div>
                <div v-if="detail.chushouTypes" class="detail-item">
                    <span>房屋状态：</span>
                    <span class="desc">
                                {{detail.chushouTypes==1?"未售":detail.chushouTypes==2?"已售":""}}
                            </span>
                </div>

                <div class="detail-item">

                    <!--<button onclick="addChushouqqqqqqqq()" type="button" class="layui-btn layui-btn-warm">
                        添加到购物车
                    </button>-->
                    <button v-if="detail.chushouTypes==1" @click="jump('../chushouOrder/add.jsp?id='+detail.id)" type="button" class="layui-btn btn-submit">
                        立即购买
                    </button>
                </div>

                <div class="detail-item" style="text-align: right;">
                </div>
            </div>
        </div>

        <div class="layui-row">
            <div class="layui-tab layui-tab-card">

                <ul class="layui-tab-title">

                    <li class="layui-this">详情</li>

                    <li>留言</li>
                </ul>

                <div class="layui-tab-content">

                    <div class="layui-tab-item layui-show">
                        <div v-html="myFilters(detail.chushouContent)"></div>
                    </div>

                    <div class="layui-tab-item">
                        <div class="message-container">
                            <form class="layui-form message-form" style="padding-right: 20px;border-bottom: 0;">
                                <div class="layui-form-item layui-form-text">
                                    <label class="layui-form-label">留言</label>
                                    <div class="layui-input-block">
                                        <textarea name="chushouLiuyanContent" id="chushouLiuyanContent" required lay-verify="required" placeholder="留言内容"
                                                  class="layui-textarea"></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-input-block">
                                        <button class="layui-btn btn-submit" lay-submit lay-filter="chushouLiuyanContent">立即提交</button>
                                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                                    </div>
                                </div>
                            </form>
                            <div class="message-list">
                                <div class="message-item" v-for="(item,index) in chushouLiuyanDataList" v-bind:key="index">
                                    <div class="username-container">
                                        <img class="avator" :src="item.yonghuPhoto">
                                        <span class="username">用户：{{item.yonghuName}}</span>
                                    </div>
                                    <div class="content">
												<span class="message">
													留言:{{item.chushouLiuyanContent}}
												</span>
                                    </div>
                                    <div class="content">
												<span class="message" style="color: #AF874D">
													回复:{{item.replyContent}}
												</span>
                                    </div>
                                </div>
                            </div>
                            <div class="pager" id="chushouLiuyanPager"></div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>


<script src="../../layui/layui.js"></script>
<script src="../../js/vue.js"></script>
<!-- 组件配置信息 -->
<script src="../../js/config.js"></script>
<!-- 扩展插件配置信息 -->
<script src="../../modules/config.js"></script>
<!-- 工具方法 -->
<script src="../../js/utils.js"></script>

<script>
    Vue.prototype.myFilters= function (msg) {
        if(msg != null){
            return msg.replace(/\n/g, "<br>");
        }else{
            return "";
        }
    };
    var vue = new Vue({
        el: '#app',
        data: {
            // 轮播图
            swiperList: [],
            // 数据详情
            detail: {
                id: 0
            },
            // 加入购物车数量
            buynumber: 1,
            // 当前详情页表
            detailTable: 'chushou',
            // 留言列表
            chushouLiuyanDataList: [],
        },
        //  清除定时器
        destroyed: function () {
            // 不知道具体作用
            // window.clearInterval(this.inter);
        },
        methods: {
            jump(url) {
                jump(url)
            }
        }
    })

    layui.use(['layer', 'form', 'element', 'carousel', 'http', 'jquery', 'laypage'], function () {
        var layer = layui.layer;
        var element = layui.element;
        var form = layui.form;
        var carousel = layui.carousel;
        var http = layui.http;
        var jquery = layui.jquery;
        var laypage = layui.laypage;

        var limit = 10;

        // 设置数量
        jquery('#buynumber').val(vue.buynumber);

        // 数据ID
        var id = http.getParam('id');
        vue.detail.id = id;

        // 当前详情
        http.request(`${vue.detailTable}/detail/` + id, 'get', {}, function (res) {
            // 详情信息
            vue.detail = res.data;
           // 轮播图片
            vue.swiperList = vue.detail.chushouPhoto ? vue.detail.chushouPhoto.split(",") : [];
            var swiperItemHtml = '';
            for (let item of vue.swiperList) {
                swiperItemHtml +=
                        '<div>' +
                        '<img class="swiper-item" src="' + item + '">' +
                        '</div>';
            }
            jquery('#swiper-item').html(swiperItemHtml);
            // 轮播图
            carousel.render({
                elem: '#swiper',
                width: swiper.width, height: swiper.height,
                arrow: swiper.arrow,
                anim: swiper.anim,
                interval: swiper.interval,
                indicator: swiper.indicator
            });
        });


        // 获取留言
        http.request(`${vue.detailTable}Liuyan/list`, 'get', {
            page: 1,
            limit: limit,
            chushouId: vue.detail.id
        }, function (res) {
            vue.chushouLiuyanDataList = res.data.list;
            // 分页
            laypage.render({
                elem: 'chushouLiuyanPager',
                count: res.data.total,
                limit: limit,
                jump: function (obj, first) {
                    //首次不执行
                    if (!first) {
                        http.request(`${vue.detailTable}Liuyan/list`, 'get', {
                            page: obj.curr,
                            limit: obj.limit,
                            chushouId: vue.detail.id
                        }, function (res) {
                            vue.chushouLiuyanDataList = res.data.list
                        })
                    }
                }
            });
        });

        // 提交留言
        form.on('submit(chushouLiuyanContent)', function (data) {
            data.yonghuId = localStorage.getItem('userid');
            data.tableName = localStorage.getItem('userTable');
            data.chushouLiuyanContent =jquery("#chushouLiuyanContent").val();
            data.chushouId = vue.detail.id;
            http.requestJson(`${vue.detailTable}Liuyan/add`, 'post', data, function (res) {
                layer.msg('留言成功', {
                    time: 2000,
                    icon: 6
                }, function () {
                    window.location.reload();
                });
                return false
            });
            return false
        });


    });



    // 添加
    /*function addChushouqqqqqqqq(){
        layui.http.requestJson(`${vue.detailTable}Cart/add`, 'post', {
            yonghuId : localStorage.getItem('userid'),
            chushouId : vue.detail.id,
            aaaaaaaa : vue.aaaaaaaa
        }, function (res) {
            if(res.code==0){
                layer.msg('添加成功', {
                    time: 2000,
                    icon: 6
                });
            }else{
                layer.msg(res.msg, {
                    time: 2000,
                    icon: 2
                });
            }
        });
    }*/


</script>
</body>
</html>
