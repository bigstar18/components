# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export LANG=zh_CN.GB18030
export JAVA_HOME=/usr/java/jdk1.6.0_13
export PATH=$HOME/bin:$JAVA_HOME/bin:$PATH
export PS1='$LOGNAME@`hostname`:${PWD/$HOME/~} $ '

echo "================================================================================"
echo "=                                                                              ="
echo "=                                                                              ="
echo "=                              新现货交易系统                                ="
echo "=                                                                              ="
echo "=                                   GNNT                version F0.0.00        ="
echo "=                                                                              ="
echo "=                                                                              ="
echo "=                                                                              ="
echo "=                                                                              ="
echo "=                                                                              ="
echo "=                                                           YYYY.MM.DD         ="
echo "=                                                                              ="
echo "================================================================================"

