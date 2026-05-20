document.addEventListener('DOMContentLoaded', function() {
    // 1. 切换登录方式（手机/账号）
    const tabs = document.querySelectorAll('.tab');
    const tabContents = document.querySelectorAll('.tab-content');

    tabs.forEach(tab => {
        tab.addEventListener('click', function() {
            // 移除所有active状态
            tabs.forEach(t => t.classList.remove('active'));
            tabContents.forEach(c => c.style.display = 'none');

            // 激活当前tab
            this.classList.add('active');
            const targetTab = this.getAttribute('data-tab');
            document.getElementById(`${targetTab}-login`).style.display = 'block';
        });
    });

    // 2. 验证码倒计时功能
    const getCodeBtn = document.getElementById('getCodeBtn');
    let countdown = 60;
    let timer = null;

    getCodeBtn.addEventListener('click', function() {
        // 协议未勾选时禁止获取验证码
        const agreeCheckbox = document.getElementById('agree');
        if (!agreeCheckbox.checked) {
            alert('请先阅读并同意《用户服务协议》和《隐私权政策》');
            return;
        }

        // 倒计时中禁止重复点击
        if (timer) return;

        // 模拟发送验证码请求（实际项目中替换为接口调用）
        alert('验证码已发送（模拟），请查收');

        // 开始倒计时
        timer = setInterval(() => {
            countdown--;
            getCodeBtn.textContent = `${countdown}s后重发`;
            getCodeBtn.style.color = '#999';
            getCodeBtn.style.cursor = 'not-allowed';

            if (countdown <= 0) {
                clearInterval(timer);
                timer = null;
                countdown = 60;
                getCodeBtn.textContent = '获取验证码';
                getCodeBtn.style.color = '#4CAF50';
                getCodeBtn.style.cursor = 'pointer';
            }
        }, 1000);
    });

    // 3. 登录按钮表单验证
    const loginBtn = document.querySelector('.login-btn');
    loginBtn.addEventListener('click', function() {
        const agreeCheckbox = document.getElementById('agree');
        if (!agreeCheckbox.checked) {
            alert('请先阅读并同意《用户服务协议》和《隐私权政策》');
            return;
        }

        // 模拟登录请求（实际项目中替换为接口调用）
        alert('登录请求已发送（模拟），请检查网络或联系管理员');
    });
});