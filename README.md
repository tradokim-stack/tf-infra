## Commands

### Khởi tạo dự án

```sh
terraform init
```

### Check syntax

```sh
terraform validate
```

### Kiểm tra plan

```sh
terraform plan
```

### Apply

```sh
terraform apply
```

### Xem output

```sh
terraform output
```

### Destroy

```sh
terraform destroy
```


## Ecs fargate

```
                 Internet
                     │
                 Route53
                     │
                    ALB
                     │
          +----------+-----------+
          │                      │
     ECS Service            Auto Scaling
        (Web)                    │
          │                      │
     +----+----+            +----+----+
     |         |            |         |
  Fargate   Fargate      Fargate   Fargate
     │
 nginx + php-fpm
     │
 ┌───┴──────────────────────────────┐
 │                                  │
RDS                            ElastiCache
 │                                  │
 └───────────────┬──────────────────┘
                 │
            Amazon S3
                 │
        CloudWatch Logs
                 │
      Secrets Manager
```

Có nên tách các service làm nhiều task definition riêng không
+ Web Service: phục vụ HTTP (Nginx + PHP-FPM), đặt sau ALB và có Auto Scaling.
+ Queue Worker Service: chạy php artisan queue:work, không cần ALB và có thể scale độc lập.
+ Scheduler: chạy php artisan schedule:run theo lịch bằng EventBridge Scheduler hoặc một ECS Scheduled Task.
+ (Tùy chọn) Horizon Service: nếu sử dụng Laravel Horizon, triển khai thành service riêng thay cho worker thông thường.


