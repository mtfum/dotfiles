
# 参考メモ: http://qiita.com/b4b4r07/items/24872cdcbec964ce2178

DOTPATH=~/.dotfiles

# git が使えるなら git
if has "git"; then
    git clone --recursive "$GITHUB_URL" "$DOTPATH"

# 使えない場合は curl か wget を使用する
elif has "curl" || has "wget"; then
    tarball="https://github.com/mtfum/dotfiles/archive/master.tar.gz"

    # どっちかでダウンロードして，tar に流す
    if has "curl"; then
        curl -L "$tarball"

    elif has "wget"; then
        wget -O - "$tarball"

    fi | tar xv -

    # 解凍したら，DOTPATH に置く
    mv -f dotfiles-master "$DOTPATH"

else
    die "curl or wget required"
fi

cd $DOTPATH
if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
fi

# 移動できたらリンクを実行する
for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME/$f"
done

IGNOREFILES=('..', '.DS_Store', '.gitignore', 'README.md')

for dotfile in .?* 
do
	if `echo ${IGNOREFILES[@]} | grep -q "$dotfile"` ; then
    	echo "😌 Ignored ${dotfile}"
    	continue
  	fi

if [[ -f $dotfile ]]; then
    ln -sf $PWD/$dotfile $TARGET
    suffix="@"
  elif [[ -d $dotfile ]]; then
    ln -sf $PWD/$dotfile $TARGET/
    suffix="/"
  fi
echo "😎 Created $1/$dotfile$suffix"
done

