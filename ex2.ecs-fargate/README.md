
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

## 2 Quy trình

### 2.1 ECR

resource "aws_ecr_repository" "laravel" {
    name = "laravel"
}

Push image

```sh
docker build -t laravel .

docker tag laravel xxx.dkr.ecr.ap-northeast-1.amazonaws.com/laravel:latest

docker push ...
```

