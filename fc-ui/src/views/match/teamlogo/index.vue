<template>
  <div class="app-container team-logo-page">
    <!-- 页面标题 -->
    <div class="page-header">球队队徽管理</div>

    <!-- 筛选栏 -->
    <div class="filter-bar">
      <el-input
        v-model="queryParams.teamName"
        placeholder="请输入球队名称"
        clearable
        class="filter-input"
        @keyup.enter="handleQuery"
      />
      <el-button type="primary" @click="handleQuery">搜索</el-button>
      <el-button @click="resetQuery">重置</el-button>
      <el-button
        type="primary"
        icon="Plus"
        class="add-btn"
        @click="handleAdd"
        v-hasPermi="['match:teamlogo:add']"
      >新增队徽</el-button>
    </div>

    <!-- 队徽表格 -->
    <el-table v-loading="loading" :data="teamLogoList" border stripe>
      <el-table-column label="队徽预览" align="center" width="100">
        <template #default="scope">
          <img v-if="scope.row.logoUrl" :src="scope.row.logoUrl" class="logo-thumb" :alt="scope.row.teamName + '队徽'" />
          <span v-else class="logo-empty">未配置</span>
        </template>
      </el-table-column>
      <el-table-column prop="teamName" label="球队名称" min-width="140" />
      <el-table-column prop="logoUrl" label="队徽URL(OSS)" min-width="260" show-overflow-tooltip>
        <template #default="scope">
          <span v-if="scope.row.logoUrl">{{ scope.row.logoUrl }}</span>
          <span v-else class="muted">—</span>
        </template>
      </el-table-column>
      <el-table-column prop="remark" label="备注" min-width="120" show-overflow-tooltip />
      <el-table-column prop="updateTime" label="更新时间" align="center" width="170">
        <template #default="scope">
          <span>{{ parseTime(scope.row.updateTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="150">
        <template #default="scope">
          <el-button
            type="text"
            icon="Edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['match:teamlogo:edit']"
          >修改</el-button>
          <el-button
            type="text"
            icon="Delete"
            class="danger-text"
            @click="handleDelete(scope.row)"
            v-hasPermi="['match:teamlogo:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 添加或修改球队队徽对话框 -->
    <el-dialog :title="title" v-model="open" width="560px" append-to-body>
      <el-form ref="teamLogoRef" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="球队名称" prop="teamName">
          <el-input v-model="form.teamName" placeholder="与比赛表中的队名保持一致,如:天津津门虎" />
        </el-form-item>
        <el-form-item label="队徽上传" prop="logoUrl">
          <el-upload
            class="logo-uploader"
            :action="uploadUrl"
            :headers="uploadHeaders"
            :show-file-list="false"
            :before-upload="handleBeforeUpload"
            :on-success="handleUploadSuccess"
            :on-error="handleUploadError"
            accept="image/png,image/jpg,image/jpeg,image/webp"
          >
            <img v-if="form.logoUrl" :src="form.logoUrl" class="logo-preview" alt="队徽预览" />
            <div v-else class="logo-uploader-placeholder">
              <el-icon><Plus /></el-icon>
              <span>点击上传队徽</span>
            </div>
          </el-upload>
          <div class="upload-tip">支持 png/jpg/webp,大小不超过 5MB,上传成功后自动保存OSS完整URL</div>
        </el-form-item>
        <el-form-item label="队徽URL">
          <el-input v-model="form.logoUrl" placeholder="OSS完整URL(上传后自动填入,也可手动粘贴)" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="选填" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="TeamLogo">
import { Plus } from '@element-plus/icons-vue'
import { getToken } from "@/utils/auth";
import { listTeamLogo, addTeamLogo, updateTeamLogo, delTeamLogo } from "@/api/match/teamLogo";

const { proxy } = getCurrentInstance();

const teamLogoList = ref([]);
const open = ref(false);
const loading = ref(true);
const title = ref("");
const baseUrl = import.meta.env.VITE_APP_BASE_API;
const uploadUrl = ref(baseUrl + "/common/upload");
const uploadHeaders = ref({ Authorization: "Bearer " + getToken() });

const data = reactive({
  form: {},
  queryParams: {
    teamName: undefined
  },
  rules: {
    teamName: [
      { required: true, message: "球队名称不能为空", trigger: "blur" }
    ]
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询球队队徽列表 */
function getList() {
  loading.value = true;
  listTeamLogo(queryParams.value).then(response => {
    teamLogoList.value = response.data || [];
    loading.value = false;
  }).catch(() => {
    loading.value = false;
  });
}

// 取消按钮
function cancel() {
  open.value = false;
  reset();
}

// 表单重置
function reset() {
  form.value = {
    id: null,
    teamName: null,
    logoUrl: null,
    remark: null
  };
  proxy.resetForm("teamLogoRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  queryParams.value.teamName = undefined;
  getList();
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加球队队徽";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  form.value = {
    id: row.id,
    teamName: row.teamName,
    logoUrl: row.logoUrl,
    remark: row.remark
  };
  open.value = true;
  title.value = "修改球队队徽";
}

/** 删除按钮操作 */
function handleDelete(row) {
  proxy.$modal.confirm('是否确认删除球队"' + row.teamName + '"的队徽记录?').then(function() {
    return delTeamLogo(row.id);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

/** 提交按钮操作 */
function submitForm() {
  proxy.$refs["teamLogoRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateTeamLogo(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addTeamLogo(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

/** 上传前校验 */
function handleBeforeUpload(file) {
  const isLt5M = file.size / 1024 / 1024 < 5;
  if (!isLt5M) {
    proxy.$modal.msgError("上传图片大小不能超过 5MB!");
    return false;
  }
  proxy.$modal.loading("正在上传队徽...");
  return true;
}

/** 上传成功:取OSS完整URL(res.url)填入表单 */
function handleUploadSuccess(res) {
  proxy.$modal.closeLoading();
  if (res.code === 200 && res.url) {
    form.value.logoUrl = res.url;
    proxy.$modal.msgSuccess("队徽上传成功,点击确定保存记录");
  } else {
    proxy.$modal.msgError(res.msg || "上传失败");
  }
}

/** 上传失败 */
function handleUploadError() {
  proxy.$modal.closeLoading();
  proxy.$modal.msgError("队徽上传失败,请检查后端OSS配置");
}

getList();
</script>

<style scoped lang="scss">
.team-logo-page {
  .page-header {
    font-size: 18px;
    font-weight: 600;
    color: #303133;
    margin-bottom: 14px;
  }

  .filter-bar {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 14px;

    .filter-input {
      width: 220px;
    }

    .add-btn {
      margin-left: auto;
    }
  }

  .logo-thumb {
    width: 48px;
    height: 48px;
    object-fit: contain;
    vertical-align: middle;
  }

  .logo-empty,
  .muted {
    color: #c0c4cc;
    font-size: 12px;
  }

  .danger-text {
    color: #f56c6c;
  }

  .logo-uploader {
    display: inline-block;
  }

  .logo-preview {
    display: block;
    width: 100px;
    height: 100px;
    object-fit: contain;
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    background: #fafafa;
  }

  .logo-uploader-placeholder {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 6px;
    width: 100px;
    height: 100px;
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    color: #8c939d;
    font-size: 12px;
    cursor: pointer;
    transition: border-color 0.2s;

    &:hover {
      border-color: #409eff;
      color: #409eff;
    }
  }

  .upload-tip {
    font-size: 12px;
    color: #909399;
    line-height: 1.6;
  }
}
</style>
