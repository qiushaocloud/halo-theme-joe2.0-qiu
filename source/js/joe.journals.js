/**文章页逻辑 */
const journalContext = {
	/* 激活列表特效 */
	initEffect() {
		$(".joe_loading").remove();
		$(".joe_journals__list").removeClass("hidden");
		if (!ThemeConfig.enable_journal_effect) return;
		new WOW({
			boxClass: "wow",
			animateClass: ThemeConfig.journal_list_effect_class || "fadeIn",
			offset: 0,
			mobile: true,
			live: true,
		}).init();
	},
	/* 点赞 */
	initLike() {
		if (!ThemeConfig.enable_like_journal) return;
		const $allItems = $(".joe_journal__item");
		if ($allItems.length) {
			$allItems.each(function (_, item) {
				const $this = $(this);
				const cid = $this.attr("data-cid");
				const clikes = +($this.attr("data-clikes") || 0);
				let agreeArr = localStorage.getItem(encryption("agree-journal"))
					? JSON.parse(
						decrypt(localStorage.getItem(encryption("agree-journal")))
					)
					: [];
				const $iconLike = $this.find(".journal-like");
				const $iconUnlike = $this.find(".journal-unlike");
				const $likeNum = $this.find(".journal-likes-num");
				if (agreeArr.includes(cid)) {
					$iconLike.hide();
					$iconUnlike.show();
				} else {
					$iconLike.show();
					$iconUnlike.hide();
				}
				$likeNum.html(clikes);
				$iconLike.on("click", function (e) {
					e.stopPropagation();
					let _loading = false;
					if (_loading) return;
					_loading = true;
					agreeArr = localStorage.getItem(encryption("agree-journal"))
						? JSON.parse(
							decrypt(localStorage.getItem(encryption("agree-journal")))
						)
						: [];
					let flag = agreeArr.includes(cid);
					$.ajax({
						url: "/api/content/journals/" + cid + "/likes",
						type: "POST",
						dataType: "json",
						data: {
							type: flag ? "disagree" : "agree",
						},
						success(res) {
							if (res.status !== 200) {
								return;
							}
							let likes = clikes;
							if (flag) {
								likes--;
								const index = agreeArr.findIndex((_) => _ === cid);
								agreeArr.splice(index, 1);
								$iconLike.show();
								$iconUnlike.hide();
							} else {
								likes++;
								agreeArr.push(cid);
								$iconLike.hide();
								$iconUnlike.show();
							}
							const name = encryption("agree-journal");
							const val = encryption(JSON.stringify(agreeArr));
							localStorage.setItem(name, val);
							$likeNum.html(likes);
						},
						error(err) {
							_loading = false;
							return Qmsg.warning(err.responseJSON.message);
						},
						complete() {
							_loading = false;
						},
					});
				});
			});
		}
	},
	/* 评论及折叠 */
	initComment() {
		if (ThemeConfig.enable_clean_mode || !ThemeConfig.enable_comment_journal)
			return;
		$(".journal_comment_expander,.journal-comment").on("click", function (e) {
			e.stopPropagation();
			const $this = $(this);
			const $parent = $this.parents(".footer-wrap");
			const compComment = $parent.find("halo-comment")[0]._wrapper.$refs.inner;
			// 展开加载评论
			if (!$parent.hasClass("open")) {
				compComment.loadComments();
			}
			$parent.toggleClass("open");
			$parent
				.find(".journal_comment_expander_txt")
				.html(($parent.hasClass("open") ? "收起" : "查看") + "评论");
		});
	},
	/* 内容折叠/展开 */
	initExpander() {
		$(".journal_content_expander i").on("click", function (e) {
			e.stopPropagation();
			$(this).parents(".joe_journal_body").toggleClass("open");
		});
	},
	/* 复制 + 版权文字 */
	// initCopy() {
	// 	const curl = location.href;
	// 	const author = $(".joe_detail").attr("data-author") || "";
	// 	$(".page-journals .joe_detail").on("copy", function (e) {
	// 		const selection = window.getSelection();
	// 		const selectionText = selection.toString().replace(/<已自动折叠>/g, "");
	// 		const appendLink = ThemeConfig.enable_copy_right_text
	// 			? ThemeConfig.copy_right_text ||
	//         `\r\n\r\n====================================<br>作者：${author}<br>来源：${ThemeConfig.blog_title}<br>链接：${curl}<br>版权声明：内容遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。`
	// 			: "";
	// 		if (window.clipboardData) {
	// 			const copytext = selectionText + appendLink;
	// 			window.clipboardData.setData("Text", copytext);
	// 			return false;
	// 		} else {
	// 			const body_element = document.body;
	// 			const copytext = selectionText + appendLink;
	// 			const newdiv = document.createElement("pre");
	// 			newdiv.style.position = "absolute";
	// 			newdiv.style.left = "-99999px";
	// 			body_element.appendChild(newdiv);
	// 			newdiv.innerHTML = copytext;
	// 			selection.selectAllChildren(newdiv);
	// 			setTimeout(function () {
	// 				body_element.removeChild(newdiv);
	// 			}, 0);
	// 		}
	// 	});
	// },
	/* 日志块折叠 */
	foldBlock() {
		const $allBlocks = $(".joe_journal_body .content-wrp");
		$allBlocks.each(function () {
			const $this = $(this);
			if (
				$this[0].getBoundingClientRect().height >=
        ThemeConfig.journal_block_height
			) {
				$this.siblings(".journal_content_expander").show();
			}
		});
	},
	/* 日志发布时间格式化 */
	formatTime() {
		const $allJournalTime = $(".joe_journal-posttime");
		$allJournalTime.each(function () {
			const $this = $(this);
			$this.html(Utils.timeAgo($this.text()));
		});
	},
};

!(function () {
	const omits = ["foldBlock"];
	document.addEventListener("DOMContentLoaded", function () {
		Object.keys(journalContext).forEach(
			(c) => !omits.includes(c) && journalContext[c]()
		);
	});
	window.addEventListener("load", function () {
		journalContext.foldBlock();
	});
})();
