package jp.co.nss.wms.ui.frag;

import jp.co.nss.wms.R;
import jp.co.nss.wms.base.BaseTitlebarFragment;

/**
 * Created by 13799 on 2018/6/29.
 */

public class MineFragment  extends BaseTitlebarFragment {

    @Override
    protected int getContentResId() {
        return R.layout.content_scrolling;
    }
    @Override
    protected int getTitleResId() {
        return -1;
    }
}
