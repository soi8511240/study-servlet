<style>
*{
    padding: 0;
    margin: 0;
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 14px;
    line-height: 1.3em;
    vertical-align: middle;
}
.wrap{
    width: 1024px;
    margin: 0 auto;
    padding-top: 40px;
}
.table-top{
    margin-top: 40px;
}
table{
    width: 100%;
    border-collapse: collapse;
    margin-top: 16px;
}
.table-list{
    border-top: 1px solid #666;
    th{
        border-bottom: 1px solid #666;
        padding: 10px;
    }
    td{
        font-size: 14px;
        padding: 0 10px;
        height: 46px;
        border-bottom: 1px solid #ccc;
        text-align: center;
    }
}

a{
    text-decoration: none;
}
a:hover{
    text-decoration: underline;
}
.table-horizontal{
    border-top: 1px solid #666;
    th,td{
        border-bottom: 1px solid #999;
        height: 40px;
        padding: 6px 20px;
        input{ height: 40px;}
    }
    th{
        border-right: 1px solid #999;
    }
    td+th{
        border-left: 1px solid #999;
    }
    label.ess{
        position: relative;
        padding-right: 10px;
    }
    label.ess::after{
        content: '*';
        position: absolute;
        right: 0;
        top: 0;
        color: red;
    }
    input{
        width: auto;
    }
}

.searchbar{
    height: 60px;
    padding: 0 40px;
    border: 1px solid #999;
    border-radius: 20px;
    display: flex;
    align-content: center;
    justify-content: center;
    gap: 8px;
    > *{
        height: 40px;
        min-width: 60px;
        align-content: center;
    }
    align-items: center;
}
input{
    height: 20px;
    padding: 1px 10px;
    border: 1px solid #999;
    border-radius: 8px;
    display: flex;
    align-items: center;
    width: 400px;
    &:focus{
        outline: none;
        padding: 0 9px;
        border: 2px solid cornflowerblue;
    }
}
input::placeholder{
    letter-spacing: -1px;
}
.btn-sr{
    background: none;
    outline: none;
    display: flex;
    height: 40px;
    padding: 1px 1px;
    border: 1px solid #999;
    border-radius: 8px;
    align-items: center;
    cursor: pointer;
    justify-content: center;
}
.btn-sr:focus,.btn-sr:hover{
    padding: 0;
    border: 2px solid cornflowerblue;
    text-decoration: underline;
}

.btns-foot{
    width: 100%;
    display: flex;
    height: 40px;
    justify-content: space-between;
    margin-top: 40px;
    .right{
    }
    .left{
    }
    .center{
        button{
            display: inline-block;
        }
    }
}

.btn{
    padding: 10px;
    border: 1px solid #999;
    border-radius: 8px;
    display: flex;
    align-items: center;
    cursor: pointer;
    font-size: 15px;
    color: #000;
    background: transparent;
}
.btn:hover{
    padding: 9px;
    text-decoration: none;
    border: 2px solid cornflowerblue;
}

.paging-area{
    display: flex;
    ul,li{
        list-style: none;
        padding: 0;
        margin: 0;
    }
    ul{
        display: flex;
        justify-content: center;
        gap: 10px;
    }
    .prev{
        margin-right: 10px;
    }
    .next{
        margin-left: 10px;
    }
    .first:hover,.prev:hover,.next:hover,.last:hover{
        text-decoration: none;
    }
    button{
        outline: none;
        border: none;
        background: none;
        cursor: pointer;
        padding: 4px;
        height: 30px;
    }
    button:hover,button.active{
        text-decoration: underline;
        font-weight: bold;
    }
}
.select{
    height: 40px;
    padding-left: 6px;
    border: 1px solid #999;
    border-radius: 8px;
    width: 140px;
}

.area-datepicker{
    width: 50%;
    display: flex;
    gap: 10px;
    align-content: center;
    line-height: 40px;
}
.input-datepicker{
    width: 140px;
    height: 40px;
}

.color-primary{
    color: cornflowerblue !important;
}
button.primary{
    background: cornflowerblue !important;
    border: none;
    color: #fff;
}
.textarea{
    width: 100%;
    height: 200px;
    padding: 10px;
}
</style>