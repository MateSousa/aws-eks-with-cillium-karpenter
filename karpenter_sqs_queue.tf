resource "aws_sqs_queue" "this" {
  name                              = "${var.eks.name}-${var.karpenter_queue.name}-karpenter"
  message_retention_seconds         = 300
  sqs_managed_sse_enabled           = var.karpenter_queue.managed_sse_enabled ? var.karpenter_queue.managed_sse_enabled : null
  kms_master_key_id                 = var.karpenter_queue.kms_master_key_id
  kms_data_key_reuse_period_seconds = var.karpenter_queue.kms_data_key_reuse_period_seconds

  tags = var.tags
}



resource "aws_sqs_queue_policy" "this" {
  queue_url = aws_sqs_queue.this.url
  policy    = data.aws_iam_policy_document.queue.json
}

resource "aws_cloudwatch_event_rule" "this" {
  for_each = { for k, v in local.events : k => v }

  name_prefix   = "${var.karpenter_queue.prefix}${each.value.name}-"
  description   = each.value.description
  event_pattern = jsonencode(each.value.event_pattern)

  tags = merge(
    { "ClusterName" : var.eks.name },
    var.tags,
  )
}

resource "aws_cloudwatch_event_target" "this" {
  for_each = { for k, v in local.events : k => v }

  rule      = aws_cloudwatch_event_rule.this[each.key].name
  target_id = "KarpenterInterruptionQueueTarget"
  arn       = aws_sqs_queue.this.arn
}
